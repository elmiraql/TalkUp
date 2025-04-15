//
//  OnboardingRouter.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 13.04.25.
//

import UIKit

protocol OnboardingRouterProtocol: AnyObject {
    func routeToLogin()
    func routeToRegister()
}

class OnboardingRouter: OnboardingRouterProtocol {
    
    weak var viewController: UIViewController?
    
    func routeToLogin() {
        let loginVC = LoginBuilder.build()
        viewController?.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    func routeToRegister(){
        let registerVC = RegistrationBuilder.build()
        viewController?.navigationController?.pushViewController(registerVC, animated: true)
    }
    
}
