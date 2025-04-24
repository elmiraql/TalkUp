//
//  ConversationView.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 17.04.25.
//

import UIKit

class ConversationView: UIView {
    
    let tableView = UITableView()
    let messageInput = InputMessageView()
    private let sendButton = UIButton(type: .system)
    
    let emptyStateLabel: UILabel = {
        let label = UILabel()
        label.text = "Здесь пока нет сообщений. \nНапишите первым, чтобы начать диалог."
        label.textColor = .gray
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.isHidden = true
        label.numberOfLines = 0
        return label
    }()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        addSubview(backgroundImageView)
        backgroundImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        
        backgroundColor = .systemGray6
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .interactive
        addSubViews(tableView, messageInput)
        messageInput.anchor(left: leftAnchor, bottom: keyboardLayoutGuide.topAnchor, right: rightAnchor, height: 56)
        tableView.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, bottom: messageInput.topAnchor, right: rightAnchor)
        
        addSubview(emptyStateLabel)
        emptyStateLabel.centerX(inView: self)
        emptyStateLabel.centerY(inView: self)
        
    }
    
}
