//
//  RegistrationInteractor.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 14.04.25.
//

import Combine
import Foundation

protocol RegistrationInteractorProtocol: AnyObject {
    func register(email: String, password: String, name: String)
//    func registerPublisher(email: String, password: String, name: String) -> AnyPublisher<Bool, Error>
}

protocol RegistrationInteractorOutput: AnyObject {
    func registrationSucceeded()
    func registrationFailed(error: String)
}

final class RegistrationInteractor: RegistrationInteractorProtocol {
   
    weak var presenter: RegistrationInteractorOutput?

    func register(email: String, password: String, name: String) {
        FirebaseFacade.shared.register(email: email, password: password) { [weak self] result in
            switch result {
            case .success:
                FirebaseFacade.shared.saveUser(email: email, displayName: name) { error in
                    if let error = error {
                        print("ошибка сохранения юзера: \(error.localizedDescription)")
                    } else {
                        print("юзер сохранён в файрстор. в коллекцию users")
                        self?.presenter?.registrationSucceeded()
                    }
                }
               
            case .failure(let error):
                self?.presenter?.registrationFailed(error: error.localizedDescription)
            }
        }
    }
}
