//
//  NutritionsSelectionInteractor.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 21.04.2021.
//

import Foundation


class NutritionsSelectionInteractor: NutritionsSelectionInteractorProtocol {
    weak var presenter: NutritionsSelectionPresenterProtocol!
    
    required init(presenter: NutritionsSelectionPresenterProtocol) {
        self.presenter = presenter
    }
}
