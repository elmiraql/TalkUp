//
//  ChatListViewController.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 16.04.25.
//

import UIKit

final class ChatListViewController: UIViewController {

    var presenter: ChatListPresenterProtocol?

    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Chats"
        setupTableView()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
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

//        guard let chat = presenter?.chat(at: indexPath.row) else { return }
//        let conversationVC = ConversationModuleBuilder.build(with: chat.user)
//        navigationController?.pushViewController(conversationVC, animated: true)
        
        AuthService.shared.logout { result in
            let onboarding = OnboardingBuilder.build()
            let nav = UINavigationController(rootViewController: onboarding)
            
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = scene.windows.first {
                window.rootViewController = nav
                window.makeKeyAndVisible()
            }
        }
    }
}
