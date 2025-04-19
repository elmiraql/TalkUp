//
//  UserListViewController.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 18.04.25.
//

import UIKit

final class UserListViewController: UIViewController {

    private var users: [UserModel] = []
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchUsers()
    }

    private func setupUI() {
        title = "Users"
        view.backgroundColor = .white
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }

    private func fetchUsers() {
        UserService.shared.fetchAllUsers { [weak self] users in
            DispatchQueue.main.async {
                self?.users = users
                self?.tableView.reloadData()
            }
        }
    }
}

extension UserListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = user.email
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        let conversationVC = ConversationModuleBuilder.build(with: user)
        navigationController?.pushViewController(conversationVC, animated: true)
    }
}
