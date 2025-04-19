//
//  InputMessageView.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 16.04.25.
//

import Foundation
import UIKit
import Combine
import CombineCocoa

final class InputMessageView: UIView {

    let container = UIView()
    let textField = UITextField()
    let micButton = UIButton(type: .system)
    let sendButton = UIButton(type: .system)
    private var cancellables = Set<AnyCancellable>()
    
    var sendPublisher: AnyPublisher<String, Never> {
        sendButton.tapPublisher
            .compactMap { [weak self] in
                self?.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            .filter { !$0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        bind()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        
    }

    private func setupUI() {
        backgroundColor = .clear
        
        addSubViews(container, textField, micButton, sendButton)

        container.backgroundColor = .white
        container.layer.cornerRadius = 10
        container.layer.borderWidth = 1
        container.layer.borderColor = UIColor.systemGray5.cgColor
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOpacity = 0.05
        container.layer.shadowOffset = CGSize(width: 0, height: 1)
        container.layer.shadowRadius = 2

        textField.placeholder = "Type here..."
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.borderStyle = .none
        textField.translatesAutoresizingMaskIntoConstraints = false

        let micImage = UIImage(systemName: "mic.fill")
        micButton.setImage(micImage, for: .normal)
        micButton.tintColor = .darkGray
        micButton.translatesAutoresizingMaskIntoConstraints = false
        
        let sendImage = UIImage(systemName: "paperplane.fill")
        sendButton.setImage(sendImage, for: .normal)
        sendButton.tintColor = .systemBlue
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.isHidden = true
        
        container.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 16, paddingBottom: 4, paddingRight: 16)
        textField.anchor(left: container.leftAnchor, right: micButton.leftAnchor, paddingLeft: 16, paddingRight: 8, height: 36)
        textField.centerY(inView: container)
        micButton.anchor(right: container.rightAnchor, paddingRight: 12, width: 24, height: 24)
        micButton.centerY(inView: container)
        sendButton.anchor(right: container.rightAnchor, paddingRight: 12, width: 24, height: 24)
        sendButton.centerY(inView: container)

    }
    
    private func bind() {
        textField.textPublisher
            .map { text in
                !(text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
            }
            .receive(on: RunLoop.main)
            .sink { [weak self] hasText in
                self?.micButton.isHidden = hasText
                self?.sendButton.isHidden = !hasText
                self?.updateButtonState()
            }
            .store(in: &cancellables)
    }
    
    func updateButtonState() {
        let text = textField.text ?? ""
        let isEmpty = text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        micButton.isHidden = !isEmpty
        sendButton.isHidden = isEmpty
    }
}
