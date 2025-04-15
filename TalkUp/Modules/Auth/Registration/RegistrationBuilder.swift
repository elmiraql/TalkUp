//
//  RegistrationBuilder.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 14.04.25.
//

import UIKit

final class RegistrationBuilder {
    static func build() -> UIViewController {
        let view = RegistrationViewController()
        let presenter = RegistrationPresenter()
        let interactor = RegistrationInteractor()
        let router = RegistrationRouter()

        view.presenter = presenter

        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router

        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}
