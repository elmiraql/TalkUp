//
//  ProfileModuleBuilder.swift
//  Super easy dev
//
//  Created by Elmira Qurbanova on 29.04.25
//

import UIKit

class ProfileModuleBuilder {
    static func build() -> ProfileViewController {
        let interactor = ProfileInteractor()
        let router = ProfileRouter()
        let presenter = ProfilePresenter(interactor: interactor, router: router)
        let viewController = ProfileViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
