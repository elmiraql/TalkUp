//
//  LoginPresenter.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 14.04.25.
//

import Foundation

protocol LoginPresenterProtocol: AnyObject {
    func didTapSignIn(email: String, password: String)
    func didTapRegister()
}

final class LoginPresenter: LoginPresenterProtocol {
    
    weak var view: LoginViewProtocol?
    var interactor: LoginInteractorProtocol?
    var router: LoginRouterProtocol?
    
    func didTapSignIn(email: String, password: String) {
        interactor?.login(email: email, password: password)
    }
    
    func didTapRegister() {
        router?.routeToRegister()
    }
}

extension LoginPresenter: LoginInteractorOutput {
    func loginSucceeded() {
        router?.routeToMain()
    }
    
    func loginFailed(error: String) {
        view?.showError(message: error)
    }
}
