//
//  ChatListView.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 23.04.25.
//

import UIKit

class ChatListView: UIView {
    
    let tableView = UITableView()
    let emptyStateLabel: UILabel = {
        let label = UILabel()
        label.text = "Нет чатов. Найдите собеседника!"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.isHidden = true // будет показываться только если список пуст
        return label
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
        
        addSubview(tableView)
        tableView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        
        addSubview(emptyStateLabel)
           emptyStateLabel.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               emptyStateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
               emptyStateLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
           ])
        
    }
}
