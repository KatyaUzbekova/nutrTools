//
//  NutritionCardInteractor.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 16.04.2021.
//

import Foundation

import Foundation

class NutritionCardInteractor: NutritionCardInteractorProtocol {
    weak var presenter: NutritionCardPresenterProtocol!
    
    required init(presenter: NutritionCardPresenterProtocol) {
        self.presenter = presenter
    }
}
