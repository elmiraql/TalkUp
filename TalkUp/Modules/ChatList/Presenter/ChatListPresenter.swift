//
//  ChatListPresenter.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 16.04.25.
//

import UIKit
import Foundation

protocol ChatListPresenterProtocol: AnyObject {
    func viewDidLoad()
    var numberOfChats: Int { get }
    func chat(at index: Int) -> ChatViewModel
    func didSelectChat(at index: Int)
    func logout()
}

final class ChatListPresenter: ChatListPresenterProtocol {
    
    private weak var view: ChatListViewProtocol?
    var interactor: ChatListInteractorProtocol!
    private var chats: [ChatViewModel] = []
    var router: ChatListRouterProtocol!

    init(view: ChatListViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        interactor?.observeChats()
    }

    var numberOfChats: Int {
        chats.count
    }
    
    func chat(at index: Int) -> ChatViewModel {
        return chats[index]
    }
    
    func didSelectChat(at index: Int) {
        let chat = chats[index]
        router.routeToChat(chat: chat)
    }
    
    func logout() {
        interactor.logout()
    }
    
   
    
}

extension ChatListPresenter: ChatListInteractorOutput {
    func didReceiveChats(_ chats: [ChatViewModel]) {
        self.chats = chats
        view?.reloadChatList()
    }
    func didLogOut(){
        view?.navigateToRoot()
    }
}
