//
//  FirebaseChatService.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 18.04.25.
//

import Foundation
import Firebase
import FirebaseAuth

final class FirebaseChatService {

    static let shared = FirebaseChatService()

    private init() {}

    private let db = Firestore.firestore()

    func createChatId(with userId: String) -> String? {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return nil }
        return [currentUserId, userId].sorted().joined(separator: "_")
    }

    func sendMessage(to receiverId: String, text: String, completion: @escaping (Error?) -> Void) {
        guard let senderId = Auth.auth().currentUser?.uid,
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
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            onUpdate([])
            return nil
        }

        guard let chatId = createChatId(with: userId) else { return nil}
        let messagesRef = Firestore.firestore()
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
}
