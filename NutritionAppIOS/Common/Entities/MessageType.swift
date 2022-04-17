//
//  MessageType.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 09.05.2021.
//

import Foundation

enum MessageType: String, Encodable {
    case IMAGE = "IMAGE"
    case PING = "PING"
    case TEXT = "TEXT"
    case REPORT = "REPORT"
    case CONNECT = "CONNECT"
    case USER_JOIN = "USER_JOIN"
    case USER_LEAVE = "USER_LEAVE"
    case MESSAGE_READ = "MESSAGE_READ"
    case TYPING = "TYPING"
}
