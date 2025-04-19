//
//  RegistrationView.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 14.04.25.
//

import UIKit

class RegistrationView: UIView {
    
    lazy var bgImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "violetbg")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "#Sign Up"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        return label
    }()
    
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
        
        addSubview(bgImageView)
        if let image = bgImageView.image {
            let aspectRatio = image.size.width / image.size.height
            bgImageView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor)
            bgImageView.heightAnchor.constraint(equalTo: bgImageView.widthAnchor, multiplier: 1 / aspectRatio).isActive = true
        }
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, emailField, passwordField, confirmField, signUpButton])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 16
        
        addSubview(stack)
        
        stack.anchor(top: bgImageView.bottomAnchor, left: leftAnchor,  right: rightAnchor, paddingTop: 32, paddingLeft: 16, paddingRight: 16)
        
    }
}
