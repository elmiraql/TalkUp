//
//  OnboardingPresenter.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 13.04.25.
//

import Foundation

protocol OnboardingPresenterProtocol: AnyObject {
    func didTapLogin()
    func didTapRegister()
}

class OnboardingPresenter: OnboardingPresenterProtocol {
   
    weak var view: OnboardingViewProtocol?
    var interactor: OnboardingInteractorProtocol?
    var router: OnboardingRouterProtocol?
    
    func didTapLogin() {
        router?.routeToLogin()
    }
    
    func didTapRegister() {
        router?.routeToRegister()
    }
    
    
    
}
