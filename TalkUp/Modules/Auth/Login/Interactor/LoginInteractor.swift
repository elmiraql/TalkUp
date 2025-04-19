//
//  LoginInteractor.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 14.04.25.
//

import Foundation

protocol LoginInteractorProtocol: AnyObject {
    func login(email: String, password: String)
}

protocol LoginInteractorOutput: AnyObject {
    func loginSucceeded()
    func loginFailed(error: String)
}

final class LoginInteractor: LoginInteractorProtocol {
    
    weak var presenter: LoginInteractorOutput?
    
    func login(email: String, password: String) {
        AuthService.shared.login(email: email, password: password) { [weak self] result in
            switch result {
            case .success:
                self?.presenter?.loginSucceeded()
            case.failure(let error):
                self?.presenter?.loginFailed(error: error.localizedDescription)
            }
        }
    }
}

