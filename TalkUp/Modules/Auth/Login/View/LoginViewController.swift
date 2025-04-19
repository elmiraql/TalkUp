//
//  LoginViewController.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 14.04.25.
//

import UIKit
import Combine

protocol LoginViewProtocol: AnyObject {
    func showError(message: String)
}

final class LoginViewController: UIViewController, LoginViewProtocol {
    
    var presenter: LoginPresenterProtocol?
    var mainView: LoginView!
    private var cancellables = Set<AnyCancellable>()

    override func loadView() {
        super.loadView()
        let contentView = LoginView()
        view = contentView
        mainView = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.signIn.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        mainView.register.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)

        bindValidation()
    }
    
    @objc private func signInTapped() {
        presenter?.didTapSignIn(email: mainView.email.text,
                                password: mainView.password.text)
    }
    
    @objc private func registerTapped() {
        presenter?.didTapRegister()
    }
 
    func showError(message: String) {
        let alert = UIAlertController(title: "Oops", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func bindValidation() {
        let emailPublisher = mainView.email.textPublisher
        let passwordPublisher = mainView.password.textPublisher
        
        Publishers.CombineLatest(emailPublisher, passwordPublisher)
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .map { email, password in
            return !email.isEmpty &&
                email.contains("@") &&
                password.count >= 6
            }
            .receive(on: RunLoop.main)
            .sink { [weak self] isValid in
                self?.mainView.signIn.isEnabled = isValid
                self?.mainView.signIn.alpha = isValid ? 1.0 : 0.5
            }
            .store(in: &cancellables)
        
        emailPublisher
            .sink { [weak self] text in
                let isValid = text.contains("@")
                self?.mainView.email.textField.layer.borderColor = isValid ? UIColor.systemGreen.cgColor : UIColor.systemRed.cgColor
            }
            .store(in: &cancellables)
    }
}
