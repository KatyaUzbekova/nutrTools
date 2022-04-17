//
//  MeasurementsModel.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 09.04.2021.
//

import Foundation


struct MeasurementsModel: Decodable {
    
    var array: [SingleMeasurement]

    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        array = []
        var stringArray: SingleMeasurement!
        while !container.isAtEnd {
            stringArray = try container.decode(SingleMeasurement.self)
            array.append(stringArray)
        }
    }
}
    
struct SingleMeasurement: Decodable {
        let weight: Double
        let neck: Double
        let waist: Double
        let chest: Double
        let hip: Double
        let calve: Double
        let date: String
}
