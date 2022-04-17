//
//  TransformationModel.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 27.05.2021.
//

import Foundation

struct TransformationModel: Decodable {
    var array: [SingleTransformation]

    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        array = []
        var stringArray: SingleTransformation!
        while !container.isAtEnd {
            stringArray = try container.decode(SingleTransformation.self)
            array.append(stringArray)
        }
    }
}

struct SingleTransformation: Decodable {
    let transformationId: CLong
    let imageListURL: [String]
    let comment: String
    let date: String
}

struct TransformationCreation: Decodable {
    let message: String?
}
