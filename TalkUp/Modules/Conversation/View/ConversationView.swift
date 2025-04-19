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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        backgroundColor = .systemGray6
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.keyboardDismissMode = .interactive
        addSubViews(tableView, messageInput)
        messageInput.anchor(left: leftAnchor, bottom: keyboardLayoutGuide.topAnchor, right: rightAnchor, height: 56)
        tableView.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, bottom: messageInput.topAnchor, right: rightAnchor)
        
    }
    
}
