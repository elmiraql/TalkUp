//
//  ConversationMessage.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 16.04.25.
//

import UIKit

enum MessageType {
    case text(String)
    case image(UIImage)
    case audio(URL)
}

struct ConversationMessage {
    let id: UUID
    let sender: String
    let timestamp: Date
    let type: MessageType
    let isIncoming: Bool
}

struct ChatMessage: Codable {
    let senderId: String
    let text: String
    let timestamp: Date
}

struct UserModel: Codable {
    let uid: String
    let email: String
    let displayName: String
}
