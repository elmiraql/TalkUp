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
        view.presenter = presenter
        return UINavigationController(rootViewController: view)
    }
    
}
