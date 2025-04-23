//
//  UserListViewController.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 18.04.25.
//

import UIKit

protocol UserListViewProtocol: AnyObject {
    func displayUsers()
}

final class UserListViewController: UIViewController, UserListViewProtocol {
   
    var presenter: UserListPresenterProtocol?
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.fetchUsers()
    }

    private func setupUI() {
        title = "Users"
        view.backgroundColor = .white
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    func displayUsers() {
       tableView.reloadData()
    }
    
    
}

extension UserListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.numberOfUsers() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let user = presenter?.user(at: indexPath.row) else { return UITableViewCell() }
        let cell = CellFactory.make(for: tableView, at: indexPath, with: user) as UserCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user = presenter?.user(at: indexPath.row) else { return }
        let conversationVC = ConversationModuleBuilder.build(with: user)
        navigationController?.pushViewController(conversationVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let user = presenter?.user(at: indexPath.row) {
            return CellLayoutProvider.height(for: .user(user))
        }
        return UITableView.automaticDimension
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
////        presenter?.didSelectChat(at: indexPath.row)
//    }
    
}

