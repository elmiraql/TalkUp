//
//  ChatCell.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 16.04.25.
//

import UIKit

final class ChatCell: UITableViewCell, ConfigurableCell {

    static let reuseId = "ChatCell"

    private let avatarImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 24
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .black
        return iv
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.text = "Text"
        return label
    }()

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.lineBreakMode = .byTruncatingTail
        return label
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .gray
        return label
    }()

    private let stack = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        contentView.addSubViews(avatarImageView, timeLabel, stack)

        stack.axis = .vertical
        stack.spacing = 4
        stack.addArrangedSubview(nameLabel)
        stack.addArrangedSubview(messageLabel)
        stack.translatesAutoresizingMaskIntoConstraints = false

        avatarImageView.anchor(left: contentView.leftAnchor, paddingLeft: 16)
        avatarImageView.centerY(inView: contentView)
        avatarImageView.setDimensions(height: 48, width: 48)
                
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12),
            stack.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            stack.trailingAnchor.constraint(lessThanOrEqualTo: timeLabel.leadingAnchor, constant: -8),
        ])
        timeLabel.anchor(top: contentView.topAnchor, right: contentView.rightAnchor, paddingTop: 20, paddingRight: 16)
        
    }

    func configure(with model: ChatViewModel) {
        nameLabel.text = model.name
        messageLabel.text = model.lastMessage
        timeLabel.text = model.time

        avatarImageView.subviews.forEach { $0.removeFromSuperview() }

        let label = UILabel()
        label.text = String(model.name.prefix(1)).uppercased()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .systemBlue
        label.clipsToBounds = true
        label.layer.cornerRadius = 24
        label.frame = avatarImageView.bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        avatarImageView.addSubview(label)
    }
}
