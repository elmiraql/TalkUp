//
//  ChatListInteractor.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 19.04.25.
//

import Foundation
import Combine

protocol ChatListInteractorProtocol {
    func observeChats()
    func logout()
}

protocol ChatListInteractorOutput: AnyObject {
    func didReceiveChats(_ chats: [ChatViewModel])
    func didLogOut()
}

class ChatListInteractor: ChatListInteractorProtocol {
   
    weak var presenter: ChatListInteractorOutput?
    private var cancellables = Set<AnyCancellable>()
    
    func observeChats() {
        FirebaseFacade.shared.fetchChatsPublisher()
            .sink { [weak self] chats in
                self?.presenter?.didReceiveChats(chats)
                
            }
            .store(in: &cancellables)
    }
    
    func logout() {
        FirebaseFacade.shared.logout { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.presenter?.didLogOut()
                }
            case .failure(let error):
                print("error: \(error.localizedDescription)")
            }
        }
    }
        
}
