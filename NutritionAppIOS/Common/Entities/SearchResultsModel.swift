//
//  SearchResultsModel.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 18.06.2021.
//

import Foundation

struct SearchResultsModel: Decodable {
    var array: [SearchFoodResult]
    var message: String?
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var stringArray: SearchFoodResult!
        array = []
        while !container.isAtEnd {
            stringArray = try container.decode(SearchFoodResult.self)
            array.append(stringArray)
        }
    }}

struct SearchFoodResult: Decodable {
    let id: CLong
    let productName: String
    let fats: Float
    let proteins: Float
    let carbs: Float
    let calories: Float
    let rating: CLong
}
