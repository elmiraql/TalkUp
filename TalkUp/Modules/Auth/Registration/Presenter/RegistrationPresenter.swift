//
//  RegistrationPresenter.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 14.04.25.
//

import UIKit
import FirebaseStorage
import Combine

protocol RegistrationPresenterProtocol: AnyObject {
    func didTapSignUp(email: String, password: String, confirmPassword: String, name: String)
}

final class RegistrationPresenter: RegistrationPresenterProtocol {
    
    weak var view: RegistrationViewProtocol?
    var interactor: RegistrationInteractorProtocol?
    var router: RegistrationRouterProtocol?
    private var cancellables = Set<AnyCancellable>()

    func didTapSignUp(email: String, password: String, confirmPassword: String, name: String) {
        if let error = validate(email: email, password: password, confirm: confirmPassword) {
            view?.showError(message: error)
        } else {
            interactor?.register(email: email, password: password, name: name)
        }
    }

    private func validate(email: String, password: String, confirm: String) -> String? {
        if email.isEmpty || password.isEmpty || confirm.isEmpty {
            return "пожалуйста заполните все поля"
        }
        if !email.contains("@") {
            return "некорректный email"
        }
        if password.count < 6 {
            return "пароль должен быть минимум 6 символов"
        }
        if password != confirm {
            return "пароля не совпадают"
        }
        return nil
    }
    
    
}

extension RegistrationPresenter: RegistrationInteractorOutput {
    
    func registrationSucceeded() {
        router?.routeToLogin()
    }

    func registrationFailed(error: String) {
        view?.showError(message: error)
    }
}
