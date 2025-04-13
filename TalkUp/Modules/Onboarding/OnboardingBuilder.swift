//
//  OnboardingBuilder.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 13.04.25.
//

import UIKit

class OnboardingBuilder {
    
    static func build() -> UIViewController {
        let view = OnboardingViewController()
        let presenter = OnboardingPresenter()
        let interactor = OnboardingInteractor()
        let router = OnboardingRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        router.viewController = view
        
        return view
    }
    
}
