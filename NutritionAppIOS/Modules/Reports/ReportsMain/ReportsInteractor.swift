//
//  ReportsInteractor.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 08.04.2021.
//

import Foundation

protocol ReportsInteractorProtocol: class {
}

class ReportsInteractor: ReportsInteractorProtocol {
    
    weak var presenter: ReportsPresenterProtocol!
    
    required init(presenter: ReportsPresenterProtocol) {
        self.presenter = presenter
    }
}
