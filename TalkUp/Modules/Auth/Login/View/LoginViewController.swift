//
//  LoginViewController.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 14.04.25.
//

import UIKit

protocol LoginViewProtocol: AnyObject {
    func showError(message: String)
}

final class LoginViewController: UIViewController, LoginViewProtocol {
    
    var presenter: LoginPresenterProtocol?
    var mainView: LoginView!

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
}
