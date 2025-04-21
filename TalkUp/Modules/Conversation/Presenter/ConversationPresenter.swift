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
    func message(at index: Int) -> MessageDisplayable
    func sendMessage(receiverId: String, text: String)
    func messageSent()
}

class ConversationPresenter: ConversationPresenterProtocol {
    
    weak var view: ConversationViewProtocol?
    var interactor: ConversationInteractorProtocol!
    var router: ConversationRouterProtocol?
    private var messages: [MessageDisplayable] = []
    
    func fetchMessages(with id: String) {
        interactor.fetchMessages(with: id)
    }
    
    func messagesFetched(_ messages: [ConversationMessage]) {
        let decorated = messages.map { decorate($0) }
        self.messages = decorated
        DispatchQueue.main.async {
            self.view?.displayMessages(decorated)
        }
    }
    
    func numberOfMessages() -> Int {
        return messages.count
    }
    
    func message(at index: Int) -> MessageDisplayable {
        return messages[index]
    }
    
    func sendMessage(receiverId: String, text: String) {
        interactor.sendMessage(text, to: receiverId)
    }
    
    func messageSent() {
        view?.messageSent()
    }
    
    private func decorate(_ message: ConversationMessage) -> MessageDisplayable {
        
        let basic = BasicMessageDecorator(wrapped: message)
        
        if case .text(let text) = message.type, text.contains("🔥") {
            return ImportantMessageDecorator(wrapped: basic)
        } else {
            return basic
        }
    }
    
    
}
