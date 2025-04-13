//
//  OnboardingRouter.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 13.04.25.
//

import UIKit

protocol OnboardingRouterProtocol: AnyObject {
    func routeToLogin()
}

class OnboardingRouter: OnboardingRouterProtocol {
    
    weak var viewController: UIViewController?
    
    func routeToLogin() {
        let loginVC = LoginBuilder.build()
        viewController?.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    
}
