//
//  LoginView.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 14.04.25.
//

import UIKit

class LoginView: UIView {
    
    lazy var bgImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "yellowbg")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "#Sign in"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        return label
    }()
    
    lazy var email: LabeledTextField = {
        var view = LabeledTextField(type: .email, placeholder: "yana.petrov@mail.com")
        return view
    }()
    
    lazy var password: LabeledTextField = {
        var view = LabeledTextField(type: .password, placeholder: "••••••••••")
        return view
    }()
    
    lazy var signIn: UIButton = {
        let button = PrimaryButton(title: "Sign in")
        button.isEnabled = false
        button.alpha = 0.5
        return button
    }()
    
    lazy var register: UIButton = {
        let button = PrimaryButton(title: "Don't have an account? Sign up here.", titleColor: .black, bgColor: .systemGray6)
        return button
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        backgroundColor = .systemGray6
        
        addSubview(bgImageView)
        if let image = bgImageView.image {
            let aspectRatio = image.size.width / image.size.height
            bgImageView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor)
            bgImageView.heightAnchor.constraint(equalTo: bgImageView.widthAnchor, multiplier: 1 / aspectRatio).isActive = true
        }
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, email, password, signIn, register])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 16
        
        addSubview(stack)
        
        stack.anchor(top: bgImageView.bottomAnchor, left: leftAnchor,  right: rightAnchor, paddingTop: 32, paddingLeft: 16, paddingRight: 16)
        
    }
    
}
