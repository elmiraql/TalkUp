//
//  ChatListRouter.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 19.04.25.
//

import UIKit

protocol ChatListRouterProtocol: AnyObject {
    func routeToChat(chat: ChatViewModel)
}

class ChatListRouter: ChatListRouterProtocol {
    
    weak var viewController: UIViewController?
    
    func routeToChat(chat: ChatViewModel) {
        let chatController = ConversationModuleBuilder.build(with: chat.user)
        viewController?.navigationController?.pushViewController(chatController, animated: true)
    }
    
    
}
