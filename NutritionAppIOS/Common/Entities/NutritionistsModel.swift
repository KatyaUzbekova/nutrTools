//
//  NutritionistsModel.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 19.04.2021.
//

import Foundation


struct NutritionistsModel: Decodable {
    
    var array: [SingleNutritionist]

    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        array = []
        var stringArray: SingleNutritionist!
        while !container.isAtEnd {
            stringArray = try container.decode(SingleNutritionist.self)
            array.append(stringArray)
        }
    }
}

struct SingleNutritionist: Decodable {
    let id: CLong
    let email: String
    let name: String
    let regDate: String
    let lastOnline: String
    let avatarUrl: String?
    let birthDate: String
    let rating: Double
    let monthPrice: CLong
    let clientsAmount: CLong
    let about: String?
    let emailApproved: Bool
    let accountApproved: Bool
    let male: Bool
    let alreadyBooked: Bool?
}
