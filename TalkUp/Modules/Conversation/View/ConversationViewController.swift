//
//  ConversationViewController.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 16.04.25.
//

import Foundation
import UIKit
import Combine

protocol ConversationViewProtocol: AnyObject {
    func displayMessages(_ messages: [ConversationMessage])
    func messageSent()
}

final class ConversationViewController: UIViewController, ConversationViewProtocol {
 
    var presenter: ConversationPresenterProtocol?
    private var mainView: ConversationView!
    private var cancellables = Set<AnyCancellable>()
    
    private var otherUser: UserModel!

    func configure(with user: UserModel) {
        self.otherUser = user
    }
    
    override func loadView() {
        super.loadView()
        let contentView = ConversationView()
        view = contentView
        mainView = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        bindSendAction()
        presenter?.fetchMessages(with: otherUser.uid)

    }

    private func setupTable() {
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        mainView.tableView.register(TextMessageCell.self, forCellReuseIdentifier: TextMessageCell.reuseId)
    }
    
    func displayMessages(_ messages: [ConversationMessage]) {
        self.mainView.tableView.reloadData()
        self.scrollToBottom()
    }
    
    func bindSendAction(){
        let textInputPublisher = mainView.messageInput.sendPublisher
        textInputPublisher
            .sink { [weak self] text in
                guard let id = self?.otherUser.uid else { return }
                self?.presenter?.sendMessage(receiverId: id, text: text)
            }
            .store(in: &cancellables)
    }
    
    func messageSent() {
        self.mainView.tableView.reloadData()
        self.scrollToBottom()
        self.mainView.messageInput.textField.text = ""
        self.mainView.messageInput.updateButtonState()
    }
    
    private func scrollToBottom(animated: Bool = true) {
        guard let count = presenter?.numberOfMessages(), count > 0 else { return }
        let lastRow = count - 1
        let indexPath = IndexPath(row: lastRow, section: 0)
        mainView.tableView.scrollToRow(at: indexPath, at: .bottom, animated: animated)
    }
}

extension ConversationViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfMessages() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let message = presenter?.message(at: indexPath.row) else { return UITableViewCell()}

        switch message.type {
        case .text(let text):
            let cell = tableView.dequeueReusableCell(withIdentifier: TextMessageCell.reuseId, for: indexPath) as! TextMessageCell
            cell.configure(with: text, isIncoming: message.isIncoming)
            return cell
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
