//
//  PrimaryButton.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 13.04.25.
//

import UIKit

final class PrimaryButton: UIButton {

    init(title: String, titleColor: UIColor = .white, bgColor: UIColor = .black) {
        super.init(frame: .zero)
        backgroundColor = bgColor
        setTitleColor(titleColor, for: .normal)
        setupUI(title: title)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI(title: "")
    }

    private func setupUI(title: String) {
        setTitle(title, for: .normal)
        
        titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        
        layer.cornerRadius = 10
        clipsToBounds = true

        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
}
