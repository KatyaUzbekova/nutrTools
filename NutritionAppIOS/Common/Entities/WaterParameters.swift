//
//  WaterParameters.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 11.06.2021.
//

import Foundation

struct WaterParameters: Decodable {
    let date: String
    let mills: CLong
    
    var dictionary: [String: Any]? {
        return ["date": date,
                    "mills": mills]
    }
}
