//
//  RegistrationViewController.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 14.04.25.
//

import UIKit
import Combine

protocol RegistrationViewProtocol: AnyObject {
    func showError(message: String)
}

final class RegistrationViewController: UIViewController, RegistrationViewProtocol {

    var presenter: RegistrationPresenterProtocol?
    var mainView: RegistrationView!
    private var cancellables = Set<AnyCancellable>()
   
    override func loadView() {
        super.loadView()
        let contentView = RegistrationView()
        view = contentView
        mainView = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        bindValidation()
    }

    private func setupActions() {
        mainView.signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
    }

    @objc private func signUpTapped() {
        presenter?.didTapSignUp(
            email: mainView.emailField.text,
            password: mainView.passwordField.text,
            confirmPassword: mainView.confirmField.text
        )
    }

    func showError(message: String) {
        let alert = UIAlertController(title: "Oops", message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func bindValidation() {
        
        let emailPublisher = mainView.emailField.textPublisher
        let passwordPublisher = mainView.passwordField.textPublisher
        let confirmPublisher = mainView.confirmField.textPublisher

         passwordPublisher
             .sink { [weak self] text in
                 let error = text.count >= 6 ? nil : "Password must be at least 6 characters"
                 self?.mainView.passwordField.setError(error)
             }
             .store(in: &cancellables)

         Publishers.CombineLatest(passwordPublisher, confirmPublisher)
             .sink { [weak self] pass, confirm in
                 let error = pass == confirm ? nil : "Passwords donot match"
                 self?.mainView.confirmField.setError(error)
             }
             .store(in: &cancellables)
        
        Publishers.CombineLatest3(emailPublisher, passwordPublisher, confirmPublisher)
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .map { email, password, confirmPassword in
                return !email.isEmpty &&
                email.contains("@") &&
                password.count >= 6 &&
                password == confirmPassword
            }
            .receive(on: RunLoop.main)
            .sink { [weak self] isValid in
                self?.mainView.signUpButton.isEnabled = isValid
                self?.mainView.signUpButton.alpha = isValid ? 1.0 : 0.5
            }
        
            .store(in: &cancellables)
        
        emailPublisher
            .sink { [weak self] text in
                let isValid = text.contains("@")
                self?.mainView.emailField.textField.layer.borderColor = isValid ? UIColor.systemGreen.cgColor : UIColor.systemRed.cgColor
                
                let error = text.contains("@") ? nil : "Email is invalid"
                self?.mainView.emailField.setError(error)
            }
            .store(in: &cancellables)
        
      
    }
}
