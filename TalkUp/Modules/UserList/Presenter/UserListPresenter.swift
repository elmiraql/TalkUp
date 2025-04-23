//
//  UserListPresenter.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 24.04.25.
//

import Foundation

protocol UserListPresenterProtocol: AnyObject {
    func fetchUsers()
    func usersFetched(users: [UserModel])
    func numberOfUsers() -> Int
    func user(at index: Int) -> UserModel
}

class UserListPresenter: UserListPresenterProtocol {
  
    weak var view: UserListViewProtocol?
     var interactor: UserListInteractorProtocol?
    var router: UserListRouterProtocol?
    private var users: [UserModel] = []
    
    func fetchUsers() {
        interactor?.fetchUsers()
    }
    
    func usersFetched(users: [UserModel]) {
        self.users = users
        view?.displayUsers()
    }
    
    func numberOfUsers() -> Int {
        users.count
    }
    
    func user(at index: Int) -> UserModel {
        users[index]
    }
    
   
}
