//
//  ChatMessage.swift
//  matchpoint
//
//  Created by Nacho Pacelli on 13/2/21.
//

import Foundation
import MessageKit

class ChatMessageSender: SenderType {
    var senderId: String
    var displayName: String
    init(senderId: String, displayName: String) {
        self.senderId = senderId
        self.displayName = displayName
    }
}

class ChatMessage: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
    
    init(sender: SenderType, messageId: String, sentDate: Date, kind: MessageKind) {
        self.sender = sender
        self.messageId = messageId
        self.sentDate = sentDate
        self.kind = kind
    }
    
    
}
