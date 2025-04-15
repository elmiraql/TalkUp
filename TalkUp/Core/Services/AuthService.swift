//
//  AuthService.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 12.04.25.
//


import FirebaseAuth

final class AuthService {
    
    static let shared = AuthService()

    private init() {}

    func register(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
