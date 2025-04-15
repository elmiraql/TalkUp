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
        if email == "test@test.com" && password == "1234" {
            presenter?.loginSucceeded()
        } else {
            presenter?.loginFailed(error: "invalid email or password")
        }
    }
}

