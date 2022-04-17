//
//  OutgoingMessages.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 25.05.2021.
//

import Foundation

class OutgoingMessages {
    var messageType = MessageType.TEXT
}

class UserJoin: OutgoingMessages {
    var token: String
    var chatId: CLong
    
    override var messageType: MessageType {
        get {
            return MessageType.USER_JOIN
        }
        set {
            
        }
    }
    
    init(token: String, chatId: CLong) {
        self.token = token
        self.chatId = chatId
    }
}


