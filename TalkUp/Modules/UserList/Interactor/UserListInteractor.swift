//
//  UserListInteractor.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 24.04.25.
//

import Foundation

protocol UserListInteractorProtocol: AnyObject {
    func fetchUsers()
}

class UserListInteractor: UserListInteractorProtocol {
   
    weak var presenter: UserListPresenterProtocol?
    
    func fetchUsers() {
        FirebaseFacade.shared.fetchAllUsers { [weak self] users in
            DispatchQueue.main.async {
                self?.presenter?.usersFetched(users: users)
            }
        }
    }
    
    
}
