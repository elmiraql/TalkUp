//
//  ChatViewModel.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 18.04.25.
//

import UIKit

struct ChatViewModel {
    let user: UserModel
    let lastMessage: String
    let time: String
    
    var name: String {
        user.displayName
    }
}
