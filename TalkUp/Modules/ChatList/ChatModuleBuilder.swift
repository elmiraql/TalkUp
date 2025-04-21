//
//  ChatModuleBuilder.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 16.04.25.
//

import UIKit

enum ChatModuleBuilder {
    
    static func build() -> UIViewController {
        let view = ChatListViewController()
        let presenter = ChatListPresenter(view: view)
        let interactor = ChatListInteractor()
        let router = ChatListRouter()
        
        view.presenter = presenter
        presenter.interactor = interactor
        interactor.presenter = presenter
        presenter.router = router
        router.viewController = view
        
//        return UINavigationController(rootViewController: view)
        return view
    }
    
}
