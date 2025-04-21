//
//  FirebaseFacade.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 21.04.25.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import Combine

final class FirebaseFacade {
    
    static let shared = FirebaseFacade()
    private init() {}
    
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    //      private let storage = Storage.storage()
    
    // MARK: - Auth
    func register(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        
        auth.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                
            }else{
                completion(.success(()))
            }
        }
        
    }
    
    func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try auth.signOut()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
    
    func createChatId(with userId: String) -> String? {
        guard let currentUserId = auth.currentUser?.uid else { return nil }
        return [currentUserId, userId].sorted().joined(separator: "_")
    }
    
    func currentUser() -> User? {
        return auth.currentUser
    }
    
    // MARK: - Firestore
    func sendMessage(to receiverId: String, text: String, completion: @escaping (Error?) -> Void) {
        guard let senderId = auth.currentUser?.uid,
              let chatId = createChatId(with: receiverId) else {
            completion(NSError(domain: "chat", code: 0, userInfo: [NSLocalizedDescriptionKey: "юзер не найден"]))
            return
        }
        
        let message = ChatMessage(
            senderId: senderId,
            text: text,
            timestamp: Date()
        )
        
        let data = try? Firestore.Encoder().encode(message)
        
        let messagesRef = db.collection("chats").document(chatId).collection("messages")
        let newMessageRef = messagesRef.document()
        
        newMessageRef.setData(data ?? [:]) { error in
            completion(error)
        }
        
        let metaRef = db.collection("chats").document(chatId)
        metaRef.setData([
            "participants": [senderId, receiverId],
            "lastMessage": text,
            "updatedAt": Timestamp(date: Date())
        ], merge: true)
    }
    
    func observeConversation(with userId: String, onUpdate: @escaping ([ConversationMessage]) -> Void) -> ListenerRegistration? {
        guard let currentUserId = auth.currentUser?.uid else {
            onUpdate([])
            return nil
        }
        
        guard let chatId = createChatId(with: userId) else { return nil}
        let messagesRef = db
            .collection("chats")
            .document(chatId)
            .collection("messages")
            .order(by: "timestamp")
        
        return messagesRef.addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else {
                onUpdate([])
                return
            }
            
            let chatMessages = documents.compactMap { doc in
                try? doc.data(as: ChatMessage.self)
            }
            
            let conversationMessages = chatMessages.map { message in
                ConversationMessage(
                    id: UUID(),
                    sender: message.senderId,
                    timestamp: message.timestamp,
                    type: .text(message.text),
                    isIncoming: message.senderId != currentUserId
                )
            }
            
            onUpdate(conversationMessages)
        }
    }
    
    func fetchChatsPublisher() -> AnyPublisher<[ChatViewModel], Never> {
        Future { promise in
            DispatchQueue.global(qos: .userInitiated).async {
                self.fetchUserChats { chats in
                    promise(.success(chats))
                }
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
    
    func fetchUserChats(completion: @escaping ([ChatViewModel]) -> Void) {
        guard let currentUserId = auth.currentUser?.uid else {
            completion([])
            return
        }
        
        db.collection("chats")
            .whereField("participants", arrayContains: currentUserId)
            .order(by: "updatedAt", descending: true)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("error:", error.localizedDescription)
                }
                
                guard let documents = snapshot?.documents else {
                    completion([])
                    return
                }
                
                var result: [ChatViewModel] = []
                let group = DispatchGroup()
                
                for doc in documents {
                    let data = doc.data()
                    let lastMessage = data["lastMessage"] as? String ?? ""
                    let updatedAt = (data["updatedAt"] as? Timestamp)?.dateValue()
                    let time = updatedAt?.formattedTime() ?? ""
                    
                    let participants = data["participants"] as? [String] ?? []
                    guard let chatPartnerId = participants.first(where: { $0 != currentUserId }) else { continue }
                    
                    group.enter()
                    
                    Firestore.firestore().collection("users").document(chatPartnerId).getDocument { userDoc, _ in
                        defer { group.leave() }
                        
                        if let userData = try? userDoc?.data(as: UserModel.self) {
                            let chat = ChatViewModel(user: userData, lastMessage: lastMessage, time: time)
                            result.append(chat)
                        }
                    }
                }
                
                group.notify(queue: .main) {
                    completion(result)
                }
            }
    }
    
    // MARK: - User
    func saveUser(email: String, displayName: String, completion: ((Error?) -> Void)? = nil) {
        guard let uid = auth.currentUser?.uid else {
            completion?(NSError(domain: "UserService", code: 0, userInfo: [NSLocalizedDescriptionKey: "no current user"]))
            return
        }
        
        let user = UserModel(uid: uid, email: email, displayName: displayName, avatarURL: "")
        let data = try? Firestore.Encoder().encode(user)
        
        db.collection("users").document(uid).setData(data ?? [:]) { error in
            completion?(error)
        }
    }
    
    func fetchAllUsers(completion: @escaping ([UserModel]) -> Void) {
        guard let currentUserId = auth.currentUser?.uid else {
            completion([])
            return
        }
        
        db.collection("users").getDocuments { snapshot, error in
            if let documents = snapshot?.documents {
                let users = documents.compactMap { doc -> UserModel? in
                    let user = try? doc.data(as: UserModel.self)
                    return user?.uid != currentUserId ? user : nil
                }
                print(users)
                completion(users)
            } else {
                completion([])
            }
        }
    }
    
}
