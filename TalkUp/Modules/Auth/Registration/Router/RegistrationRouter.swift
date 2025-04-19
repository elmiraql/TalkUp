//
//  RegistrationRouter.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 14.04.25.
//

import UIKit

protocol RegistrationRouterProtocol: AnyObject {
    func routeToLogin()
}

final class RegistrationRouter: RegistrationRouterProtocol {
    
    weak var viewController: UIViewController?

    func routeToLogin() {
        viewController?.navigationController?.popViewController(animated: true)
        
    }
}
