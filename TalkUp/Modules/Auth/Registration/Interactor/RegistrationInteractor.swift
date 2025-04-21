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
        FirebaseFacade.shared.register(email: email, password: password) { [weak self] result in
            switch result {
            case .success:
                FirebaseFacade.shared.saveUser(email: email, displayName: "Какое то имя") { error in
                    if let error = error {
                        print("ошибка сохранения юзера: \(error.localizedDescription)")
                    } else {
                        print("юзер сохранён в Firestore. в коллекцию users")
                        self?.presenter?.registrationSucceeded()
                    }
                }
               
            case .failure(let error):
                self?.presenter?.registrationFailed(error: error.localizedDescription)
            }
        }
    }
}
