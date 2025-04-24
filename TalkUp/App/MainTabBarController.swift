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
        let chatsNav = UINavigationController(rootViewController: chats)
        chatsNav.tabBarItem = UITabBarItem(title: "Chats", image: UIImage(systemName: "message"), tag: 0)
        
        let usersVC = UserListBuilder.build()
        let usersNav = UINavigationController(rootViewController: usersVC)
        usersNav.tabBarItem = UITabBarItem(title: "Users", image: UIImage(systemName: "person.2.fill"), tag: 1)
        
//        navigationController?.navigationBar.prefersLargeTitles = true
//            navigationItem.largeTitleDisplayMode = .always
        
        //        let profile = ProfileModuleBuilder.build()
        //        profile.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)
        
        viewControllers = [chatsNav, usersNav] //profile
//        viewControllers = [chats, usersVC]
    }
    
}
