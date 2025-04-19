//
//  MainTabBarController.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 15.04.25.
//

import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTabs()
    }

    private func setupTabs() {
        let chats = ChatModuleBuilder.build()
        chats.tabBarItem = UITabBarItem(title: "Chats", image: UIImage(systemName: "message"), tag: 0)
        
        let usersVC = UserListViewController()
        usersVC.tabBarItem = UITabBarItem(title: "Users", image: UIImage(systemName: "person.2.fill"), tag: 1)

//        let profile = ProfileModuleBuilder.build()
//        profile.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)

        viewControllers = [chats, usersVC] //profile
    }
}
