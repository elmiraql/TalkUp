//
//  RegistrationInteractor.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 14.04.25.
//

protocol RegistrationInteractorProtocol: AnyObject {
    func register(email: String, password: String)
}

protocol RegistrationInteractorOutput: AnyObject {
    func registrationSucceeded()
    func registrationFailed(error: String)
}

final class RegistrationInteractor: RegistrationInteractorProtocol {
    
    weak var presenter: RegistrationInteractorOutput?

    func register(email: String, password: String) {
        AuthService.shared.register(email: email, password: password) { [weak self] result in
            switch result {
            case .success:
                self?.presenter?.registrationSucceeded()
            case .failure(let error):
                self?.presenter?.registrationFailed(error: error.localizedDescription)
            }
        }
    }
}
