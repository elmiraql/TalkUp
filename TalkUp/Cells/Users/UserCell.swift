//
//  UserCell.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 23.04.25.
//

import UIKit

final class UserCell: UITableViewCell, ConfigurableCell {
    
    static let reuseId = "UserCell"

    private let avatarLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.backgroundColor = .systemBlue
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 20
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(avatarLabel)
        contentView.addSubview(nameLabel)

        NSLayoutConstraint.activate([
            avatarLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            avatarLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarLabel.widthAnchor.constraint(equalToConstant: 40),
            avatarLabel.heightAnchor.constraint(equalTo: avatarLabel.widthAnchor),

            nameLabel.leadingAnchor.constraint(equalTo: avatarLabel.trailingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameLabel.centerYAnchor.constraint(equalTo: avatarLabel.centerYAnchor)
        ])
    }

    func configure(with user: UserModel) {
        nameLabel.text = user.displayName
        if let firstChar = user.displayName.first {
            avatarLabel.text = String(firstChar).uppercased()
        } else {
            avatarLabel.text = "?"
        }
    }
}
