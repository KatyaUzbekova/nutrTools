//
//  ReportsModel.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 11.04.2021.
//

import Foundation


struct ArrayReportsModel: Decodable {
    var array: [ReportsModel]

    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var stringArray: ReportsModel!
        array = []
        while !container.isAtEnd {
            stringArray = try container.decode(ReportsModel.self)
            array.append(stringArray)
        }
    }
    
}

struct ReportsModel: Decodable {
    let reportDate: String
    let reports: [SingleReport]
}

struct SingleReport: Decodable {
    let reportId: CLong
    let userId: CLong
    var comment: String
    let imageURL: String
    let reportDate: String
}
