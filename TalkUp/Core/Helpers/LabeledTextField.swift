//
//  LabeledTextField.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 14.04.25.
//

import UIKit
import Combine

final class LabeledTextField: UIView {
    
    enum FieldType {
        case email
        case password
        case repeatePassword
    }
    
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: textField)
            .compactMap { ($0.object as? UITextField)?.text }
            .eraseToAnyPublisher()
    }

    private let label = UILabel()
    let textField = UITextField()
    private let toggleButton = UIButton(type: .system)
    private let errorLabel = UILabel()
    
    var text: String {
        textField.text ?? ""
    }

    private var isSecure: Bool = false
    
    init(type: FieldType, placeholder: String) {
        super.init(frame: .zero)
        setupUI(type: type, placeholder: placeholder)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI(type: .email, placeholder: "")
    }

    private func setupUI(type: FieldType, placeholder: String) {
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .darkText

        switch type {
        case .email: label.text = "Email"
        case .password: label.text = "Password"
        case .repeatePassword: label.text = "Repeate password"
        }

        textField.placeholder = placeholder
        textField.font = .systemFont(ofSize: 16)
        textField.autocapitalizationType = .none
        textField.setLeftPaddingPoints(12)
        textField.setRightPaddingPoints(type == .password ? 40 : 12)
        
        textField.borderStyle = .none
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 16
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray4.cgColor

        if type == .password {
            isSecure = true
            textField.isSecureTextEntry = true

            toggleButton.setImage(UIImage(systemName: "eye"), for: .normal)
            toggleButton.tintColor = .gray
            toggleButton.addTarget(self, action: #selector(togglePassword), for: .touchUpInside)
            toggleButton.translatesAutoresizingMaskIntoConstraints = false
            addSubview(toggleButton)
        }
        
        errorLabel.font = .systemFont(ofSize: 12)
        errorLabel.textColor = .systemRed
        errorLabel.numberOfLines = 0
        errorLabel.isHidden = true

        let stack = UIStackView(arrangedSubviews: [label, textField, errorLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),

            textField.heightAnchor.constraint(equalToConstant: 48),

            bottomAnchor.constraint(equalTo: stack.bottomAnchor)
        ])

        if type == .password {
            NSLayoutConstraint.activate([
                toggleButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -12),
                toggleButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
                toggleButton.widthAnchor.constraint(equalToConstant: 24),
                toggleButton.heightAnchor.constraint(equalToConstant: 24)
            ])
        }
    }

    @objc private func togglePassword() {
        isSecure.toggle()
        textField.isSecureTextEntry = isSecure
        let imageName = isSecure ? "eye" : "eye.slash"
        toggleButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    func setError(_ message: String?) {
        if let message = message, !message.isEmpty {
            errorLabel.text = message
            errorLabel.isHidden = false
            textField.layer.borderColor = UIColor.systemRed.cgColor
        } else {
            errorLabel.text = nil
            errorLabel.isHidden = true
            textField.layer.borderColor = UIColor.systemGray4.cgColor
        }
    }
}
