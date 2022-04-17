//
//  MessageModel.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 06.05.2021.
//

import Foundation


struct MessageModel: Decodable {
    var array: [SingleMessageModel]
    var lastDateRefernced = Date(timeIntervalSinceReferenceDate: -123456789.0)
    var firstUnreaded: Int = -1
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var stringArray: SingleMessageModel!
        array = []
        while !container.isAtEnd {
            stringArray = try container.decode(SingleMessageModel.self)
            if stringArray.incoming && !stringArray.read &&  firstUnreaded == -1{
                firstUnreaded = array.count
            }
            let messageTime = convertStringToDateFormat(from: stringArray.sendDate)
            if lastDateRefernced.fullDistance(from: messageTime, resultIn: .day)! > 0 {
                stringArray.isNewDate = true
                lastDateRefernced = messageTime
                stringArray.lastDate = lastDateRefernced
            }
            else {
                stringArray.isNewDate = false
                stringArray.lastDate = lastDateRefernced
            }
            
            array.append(stringArray)
        }
    }
}

struct SingleMessageModel: Decodable {
    let name: String
    let avatarUrl: String?
    let messageId: CLong
    let chatId: CLong
    let senderId: CLong
    let messageType: String // "TEXT"
    var text: String
    let sendDate: String // "07-05-2021 14:31"
    let read: Bool
    let incoming: Bool
    var isNewDate: Bool?
    var lastDate: Date?
}


extension Date {
    func fullDistance(from date: Date, resultIn component: Calendar.Component, calendar: Calendar = .current) -> Int? {
        calendar.dateComponents([component], from: self, to: date).value(for: component)
    }
}

func convertStringToDateFormat(from string: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat =  "dd-MM-yyyy HH:mm"
    let timeInDateFormat = dateFormatter.date(from: string)
    return timeInDateFormat!
}

