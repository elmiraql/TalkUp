//
//  UserListBuilder.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 24.04.25.
//

import UIKit

class UserListBuilder {
    
    static func build() -> UIViewController {
        let view = UserListViewController()
        let presenter = UserListPresenter()
        let interactor = UserListInteractor()
        let router = UserListRouter()
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        router.viewController = view
        interactor.presenter = presenter
        return view
    }
    
}
