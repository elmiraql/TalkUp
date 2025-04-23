//
//  UserService.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 18.04.25.
//

import FirebaseFirestore
import FirebaseAuth

final class UserService {

    static let shared = UserService()
    private init() {}

    private let db = Firestore.firestore()

    func saveUser(email: String, displayName: String, completion: ((Error?) -> Void)? = nil) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion?(NSError(domain: "UserService", code: 0, userInfo: [NSLocalizedDescriptionKey: "no current user"]))
            return
        }

        let user = UserModel(uid: uid, email: email, displayName: displayName)
        let data = try? Firestore.Encoder().encode(user)

        db.collection("users").document(uid).setData(data ?? [:]) { error in
            completion?(error)
        }
    }
    
    func fetchAllUsers(completion: @escaping ([UserModel]) -> Void) {
        guard let currentUserId = Auth.auth().currentUser?.uid else {
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
