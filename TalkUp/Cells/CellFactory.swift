//
//  ChatCellFactory.swift
//  TalkUp
//
//  Created by Elmira Qurbanova on 16.04.25.
//

import UIKit

protocol ConfigurableCell {
    associatedtype DataType
    static var reuseId: String { get }
    func configure(with model: DataType)
}

enum CellFactory {

    static func make<Cell: UITableViewCell & ConfigurableCell>(
        for tableView: UITableView,
        at indexPath: IndexPath,
        with model: Cell.DataType
    ) -> Cell {

        if tableView.dequeueReusableCell(withIdentifier: Cell.reuseId) == nil {
            tableView.register(Cell.self, forCellReuseIdentifier: Cell.reuseId)
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseId, for: indexPath) as? Cell else {
            fatalError("could not dequeue cell with id: \(Cell.reuseId)")
        }
        cell.configure(with: model)
        return cell
    }
    
}

enum CellLayoutProvider {
    static func height(for item: ListItem) -> CGFloat {
        switch item {
        case .chat: return 70
        case .user: return 70
//        case .settings:
//            return 50
//        case .notification:
//            return 60
//        case .message(let message):
//            switch message.type {
//            case .text(let text):
//                return text.count < 50 ? 60 : 100
//            case .image:
//                return 220
//            case .audio:
//                return 100
//            }
        }
    }
}

enum ListItem {
    case chat(ChatViewModel)
    case user(UserModel)
//    case message(ConversationMessage)
//    case settings(SettingsItem)
//    case notification(NotificationItem)
}

