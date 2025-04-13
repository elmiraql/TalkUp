//
//  OnboardingViewController.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 13.04.25.
//

import UIKit

protocol OnboardingViewProtocol: AnyObject {}

class OnboardingViewController: UIViewController, OnboardingViewProtocol {
    
    var presenter: OnboardingPresenterProtocol?
    var mainView: OnboardingView!
    
    override func loadView() {
        super.loadView()
        let contentView = OnboardingView()
        view = contentView
        mainView = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
