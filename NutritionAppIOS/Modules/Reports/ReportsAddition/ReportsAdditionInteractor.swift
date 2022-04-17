//
//  ReportsAdditionInteractor.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 09.04.2021.
//

import Foundation

protocol ReportsAdditionInteractorProtocol: class {
}

class ReportsAdditionInteractor: ReportsAdditionInteractorProtocol {
    
    weak var presenter: ReportsAdditionPresenterProtocol!
    
    required init(presenter: ReportsAdditionPresenterProtocol) {
        self.presenter = presenter
    }
}
