//
//  ChatListPresenter.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 16.04.25.
//

import UIKit
import Foundation

protocol ChatListPresenterProtocol: AnyObject {
    
    var numberOfChats: Int { get }
    func chat(at index: Int) -> ChatViewModel
}

final class ChatListPresenter: ChatListPresenterProtocol {
    
    private weak var view: ChatListViewController?

    private var chats: [ChatViewModel] = [
        ChatViewModel(
            user: UserModel(uid: "123", email: "john@example.com", displayName: "John"),
            lastMessage: "Hey, how are you?",
            time: "12:12",
            avatar: UIImage(named: "image"),
            name: "Jon"
        ),
        ChatViewModel(
            user: UserModel(uid: "456", email: "jane@example.com", displayName: "Jane"),
            lastMessage: "Let’s meet at 6",
            time: "14:45",
            avatar: UIImage(named: "image"),
            name: "Jon"
        ),
        ChatViewModel(
            user: UserModel(uid: "789", email: "max@example.com", displayName: "Max"),
            lastMessage: "Call me!",
            time: "16:10",
            avatar: UIImage(named: "image"),
            name: "Jon"
        )
    ]

    init(view: ChatListViewController) {
        self.view = view
    }

    var numberOfChats: Int {
        chats.count
    }
    
    func chat(at index: Int) -> ChatViewModel {
        return chats[index]
    }
}
