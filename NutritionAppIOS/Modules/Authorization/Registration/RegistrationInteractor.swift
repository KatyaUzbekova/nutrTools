//
//  RegistrationInteractor.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 13.05.2021.
//

import Foundation

protocol RegistrationInteractorProtocol: class {
    func requestAgrementUrl()
}

class RegistrationInteractor: RegistrationInteractorProtocol {
    weak var presenter: RegistrationPresenterProtocol!
    
    required init(presenter: RegistrationPresenterProtocol) {
        self.presenter = presenter
    }
    
    func requestAgrementUrl() {
        ApiService.shared.openAgreementRequest() {
            data,_ in
            if let safeData = data {
                self.presenter.setupAgreement(with: safeData.url)
            }
        }
    }
}
