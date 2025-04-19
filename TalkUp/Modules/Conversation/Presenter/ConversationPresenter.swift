//
//  ConversationPresenter.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 19.04.25.
//

import Foundation

protocol ConversationPresenterProtocol: AnyObject {
    func fetchMessages(with id: String)
    func messagesFetched(_ messages: [ConversationMessage])
    func numberOfMessages() -> Int
    func message(at index: Int) -> ConversationMessage
    func sendMessage(receiverId: String, text: String)
    func messageSent()
}

class ConversationPresenter: ConversationPresenterProtocol {
    
    weak var view: ConversationViewProtocol?
    var interactor: ConversationInteractorProtocol!
    var router: ConversationRouterProtocol?
    private var messages: [ConversationMessage] = []
    
    func fetchMessages(with id: String) {
        interactor.fetchMessages(with: id)
    }
    
    func messagesFetched(_ messages: [ConversationMessage]) {
        self.messages = messages
        DispatchQueue.main.async {
            self.view?.displayMessages(messages)
        }
        
    }
    
    func numberOfMessages() -> Int {
        return messages.count
    }
    
    func message(at index: Int) -> ConversationMessage {
        return messages[index]
    }
    
    func sendMessage(receiverId: String, text: String) {
        interactor.sendMessage(text, to: receiverId)
    }
    
    func messageSent() {
        view?.messageSent()
    }
    
    
    
    
}
