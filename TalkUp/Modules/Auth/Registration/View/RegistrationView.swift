//
//  RegistrationView.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 14.04.25.
//

import UIKit

class RegistrationView: UIView {

    private let scrollView = UIScrollView()
    private let contentView = UIView()
//    let avatarContainer = UIView()
//    let avatarSelector = AvatarSelectorView()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "#Sign Up"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        return label
    }()
    
     let nameField = LabeledTextField(type: .name, placeholder: "Enter your name")
     let emailField = LabeledTextField(type: .email, placeholder: "you@example.com")
     let passwordField = LabeledTextField(type: .password, placeholder: "••••••••")
     let confirmField = LabeledTextField(type: .repeatePassword, placeholder: "••••••••")
     let signUpButton = PrimaryButton(title: "Sign Up")

    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        backgroundColor = .systemGray6
        
        signUpButton.isEnabled = false
        signUpButton.alpha = 0.5
        
//        avatarContainer.addSubview(avatarSelector)
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, nameField, emailField, passwordField, confirmField, signUpButton])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 16

//        avatarSelector.centerX(inView: avatarContainer)
//        avatarSelector.anchor(top: avatarContainer.topAnchor, bottom: avatarContainer.bottomAnchor, width: screenWidth/2, height: screenWidth/2)
        
        stack.translatesAutoresizingMaskIntoConstraints  = false
        
        addSubview(scrollView)
        scrollView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        
        scrollView.addSubview(contentView)
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor)
        
        contentView.addSubview(stack)
        stack.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 32, paddingLeft: 16, paddingBottom: 32, paddingRight: 16)

    }
}
