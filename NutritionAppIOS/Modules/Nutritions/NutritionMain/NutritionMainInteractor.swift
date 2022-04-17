//
//  NutritionMainInteractor.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 15.04.2021.
//

import Foundation

class NutritionMainInteractor: NutritionMainInteractorProtocol{
    weak var presenter: NutritionMainPresenterProtocol!

    required init(presenter: NutritionMainPresenterProtocol) {
        self.presenter = presenter
    }
}

