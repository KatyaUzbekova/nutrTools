//
//  NutritionistsGroupingModel.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 19.04.2021.
//

import Foundation

struct NutritionistsGroupingModel: Decodable {
    let bookedNutritionists: [SingleNutritionist]
    let submittedNutritionists: [SingleNutritionist]
    let activatedNutritionists: [SingleNutritionist]
}
