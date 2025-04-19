//
//  ConversationBuilder.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 16.04.25.
//

import UIKit

enum ConversationModuleBuilder {
    static func build(with user: UserModel) -> UIViewController {
        let view = ConversationViewController()
        let presenter = ConversationPresenter()
        let interactor = ConversationInteractor()
        let router = ConversationRouter()
        
        view.presenter = presenter
        view.configure(with: user)
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.viewController = view
        interactor.presenter = presenter
        
        return view
    }
}
