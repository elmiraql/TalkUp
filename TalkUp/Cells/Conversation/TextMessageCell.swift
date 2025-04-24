//
//  TextMessageCell.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 16.04.25.
//

import UIKit

final class TextMessageCell: UITableViewCell {
    
    static let reuseId = "TextMessageCell"

    private let bubble = UIView()
    private let messageLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        selectionStyle = .none
        contentView.addSubview(bubble)
        bubble.layer.cornerRadius = 16
        bubble.backgroundColor = .systemGray5
        bubble.translatesAutoresizingMaskIntoConstraints = false
//        contentView.backgroundColor = .clear
//        backgroundColor = .clear

        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont.systemFont(ofSize: 16)
        bubble.addSubview(messageLabel)

        messageLabel.anchor(top: bubble.topAnchor, left: bubble.leftAnchor, bottom: bubble.bottomAnchor, right: bubble.rightAnchor, paddingTop: 8, paddingLeft: 12, paddingBottom: 8, paddingRight: 12)
    }

    func configure(with message: MessageDisplayable) {
        
        messageLabel.text = extractText(from: message.type)
        
        switch message.style {
        case .normal:
            backgroundColor = .clear
        case .highlighted:
            backgroundColor = .systemYellow.withAlphaComponent(0.3)
        case .important:
            backgroundColor = .systemRed.withAlphaComponent(0.2)
        }
        
        bubble.backgroundColor = message.isIncoming ? UIColor.systemGray5 : UIColor.systemBlue.withAlphaComponent(0.8)
        messageLabel.textColor = message.isIncoming ? .label : .white
        
        bubble.translatesAutoresizingMaskIntoConstraints = false
        bubble.removeFromSuperview()
        contentView.addSubview(bubble)

        let leading = bubble.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        let trailing = bubble.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)

        NSLayoutConstraint.deactivate([leading, trailing])
        NSLayoutConstraint.activate([
            bubble.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            bubble.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            message.isIncoming ? leading : trailing,
            bubble.widthAnchor.constraint(lessThanOrEqualToConstant: 280)
        ])
    }
    
    private func extractText(from type: MessageType) -> String {
        switch type {
        case .text(let value): return value
        default: return "не поддерживается"
        }
    }
}
