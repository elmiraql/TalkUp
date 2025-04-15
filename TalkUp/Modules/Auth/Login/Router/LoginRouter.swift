//
//  LoginRouter.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 14.04.25.
//

import UIKit

protocol LoginRouterProtocol: AnyObject {
    func routeToRegister()
    func routeToMain()
}

final class LoginRouter: LoginRouterProtocol {
    
    weak var viewController: UIViewController?
    
    func routeToRegister() {
        let registrationVC = RegistrationBuilder.build()
        viewController?.navigationController?.pushViewController(registrationVC, animated: true)
    }
    
    func routeToMain() {
        print("routing to main screen TabBarController")
    }
}
