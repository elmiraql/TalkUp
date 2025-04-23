//
//  ConversationMessage.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 16.04.25.
//

import UIKit

protocol MessageDisplayable {
    var id: UUID { get }
    var sender: String { get }
    var timestamp: Date { get }
    var type: MessageType { get }
    var isIncoming: Bool { get }
    var style: MessageStyle { get }
}

enum MessageType {
    case text(String)
    case image(UIImage)
    case audio(URL)
}

enum MessageStyle {
    case normal
    case highlighted
    case important
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
//    let avatarURL: String?
}

struct BasicMessageDecorator: MessageDisplayable {
    let wrapped: ConversationMessage
    
    var id: UUID { wrapped.id }
    var sender: String { wrapped.sender }
    var timestamp: Date { wrapped.timestamp }
    var type: MessageType { wrapped.type }
    var isIncoming: Bool { wrapped.isIncoming }
    var style: MessageStyle { .normal }
}

struct ImportantMessageDecorator: MessageDisplayable {
    let wrapped: MessageDisplayable
    
    var id: UUID { wrapped.id }
    var sender: String { wrapped.sender }
    var timestamp: Date { wrapped.timestamp }
    var type: MessageType { wrapped.type }
    var isIncoming: Bool { wrapped.isIncoming }
    var style: MessageStyle { .important }
}
