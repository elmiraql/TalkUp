//
//  OnboardingView.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 13.04.25.
//

import UIKit

class OnboardingView: UIView {
    
    lazy var bgImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "image")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "#Checked"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Talk, text, and share as much as you want -- all of it for free"
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var getStarted: UIButton = {
        let button = PrimaryButton(title: "Get Started")
        return button
    }()
    
    lazy var login: UIButton = {
        let button = PrimaryButton(title: "I already have an account", titleColor: .black, bgColor: .systemGray6)
        return button
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        backgroundColor = .systemGray6
        
        addSubViews(bgImageView, titleLabel, subTitleLabel, getStarted, login)
        
        if let image = bgImageView.image {
            let aspectRatio = image.size.width / image.size.height
            bgImageView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor)
            bgImageView.heightAnchor.constraint(equalTo: bgImageView.widthAnchor, multiplier: 1 / aspectRatio).isActive = true
        }
        
        titleLabel.anchor(top: bgImageView.bottomAnchor, left: leftAnchor, paddingTop: 32, paddingLeft: 16)
        subTitleLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        getStarted.anchor(top: subTitleLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 32, paddingLeft: 16, paddingRight: 16, height: 60)
        login.anchor(top: getStarted.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16, height: 60)

    }
}
