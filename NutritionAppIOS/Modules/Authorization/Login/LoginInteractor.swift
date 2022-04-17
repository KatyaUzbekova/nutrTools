//
//  LoginInteractor.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 24.05.2021.
//

import Foundation

protocol LoginInteractorProtocol: class {
    
}

class LoginInteractor: LoginInteractorProtocol {
    weak var presenter: LoginPresenterProtocol!
    
    required init(presenter: LoginPresenterProtocol) {
        self.presenter = presenter
    }
}
