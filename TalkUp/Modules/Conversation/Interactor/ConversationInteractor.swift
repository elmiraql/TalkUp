//
//  ConversationInteractor.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 19.04.25.
//

import Foundation
import FirebaseFirestore


protocol ConversationInteractorProtocol: AnyObject {
    func fetchMessages(with id: String)
    func sendMessage(_ message: String, to id: String)
}

class ConversationInteractor: ConversationInteractorProtocol {
    
    weak var presenter: ConversationPresenterProtocol?
    private var listener: ListenerRegistration?

    func fetchMessages(with id: String) {
        listener = FirebaseChatService.shared.observeConversation(with: id) { [weak self] messages in
            self?.presenter?.messagesFetched(messages)
        }
    }
    
    func sendMessage(_ message: String, to id: String) {
        FirebaseChatService.shared.sendMessage(to: id, text: message) { [weak self] error in
            if let error = error {
                print("не получилось отправить сообщение: \(error.localizedDescription)")
            }else{
                self?.presenter?.messageSent()
            }
        }
    }
    
    deinit{
        listener?.remove()
    }
}
