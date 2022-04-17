//
//  MessageBySockets.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 31.05.2021.
//

import Foundation

struct MessageBySockets: Encodable {
    let token: String
    let chatId: CLong
    let message: String?
    let messageType: MessageType
    let messageId: CLong?

    var dictionary: [String: Any] {
        let messageTypeRawValue = messageType.rawValue
        switch messageTypeRawValue {
        case "TEXT":
            return ["token": token,
                    "chatId": chatId,
                    "message": message!,
                    "messageType": messageTypeRawValue]
        case "TYPING", "USER_JOIN":
            return ["token": token,
                    "chatId": chatId,
                    "messageType": messageTypeRawValue]
        case "MESSAGE_READ":
            return ["token": token,
                    "chatId": chatId,
                    "messageId": messageId!,
                    "messageType": messageTypeRawValue]
        default:
            return [:]
        }

    }
    var nsDictionary: NSDictionary {
        return dictionary as NSDictionary
    }
}
