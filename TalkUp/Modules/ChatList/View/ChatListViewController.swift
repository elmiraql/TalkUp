//
//  ChatListViewController.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 16.04.25.
//

import UIKit

protocol ChatListViewProtocol: AnyObject {
    func reloadChatList()
    func navigateToRoot()
}

final class ChatListViewController: UIViewController, ChatListViewProtocol {

    var presenter: ChatListPresenterProtocol?
    var mainView: ChatListView!
    
    override func loadView() {
        super.loadView()
        let contentView = ChatListView()
        view = contentView
        mainView = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Chats"
        setupTableView()
        presenter?.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Log Out",
            style: .plain,
            target: self,
            action: #selector(logoutTapped)
        )
    }

    private func setupTableView() {
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
    }
    
    func reloadChatList() {
        mainView.tableView.reloadData()
        let isEmpty = presenter?.numberOfChats == 0
        mainView.emptyStateLabel.isHidden = !isEmpty
        mainView.tableView.isHidden = isEmpty
    }
    
    @objc private func logoutTapped() {
        presenter?.logout()
    }
    
    func navigateToRoot(){
        let onboardingVC = OnboardingBuilder.build()
        let nav = UINavigationController(rootViewController: onboardingVC)
        self.view.window?.rootViewController = nav
    }
}

extension ChatListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.numberOfChats ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = presenter?.chat(at: indexPath.row) else { return UITableViewCell() }
        let cell = CellFactory.make(for: tableView, at: indexPath, with: model) as ChatCell
        return cell
    }
}

extension ChatListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let chat = presenter?.chat(at: indexPath.row) {
            return CellLayoutProvider.height(for: .chat(chat))
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.didSelectChat(at: indexPath.row)
    }
}
