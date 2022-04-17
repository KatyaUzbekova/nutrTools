//
//  ChatListItemModel.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 06.05.2021.
//

import Foundation

struct ChatListItemsModel: Decodable {
    var array: [ChatListItemModel]
    var message: String?
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var stringArray: ChatListItemModel!
        array = []
        while !container.isAtEnd {
            stringArray = try container.decode(ChatListItemModel.self)
            array.append(stringArray)
        }
    }
}

struct ChatListItemModel: Decodable {
    let nutritionistId: CLong
    let nutritionistName: String
    let clientId: CLong
    let clientName: String
    let nutritionistImageUrl: String?
    let clientImageUrl: String?
    let chatId: CLong
    let lastMessage: String?
    let clientIsMale:Bool
    let lastMessageType: String?
    let messageSent: String
    let nutritionistIsMale: Bool
    let read: Bool
    let outgoing: Bool
}
