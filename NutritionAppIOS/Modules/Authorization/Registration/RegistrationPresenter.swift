//
//  RegistrationPresenter.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 13.05.2021.
//

import Foundation

protocol RegistrationPresenterProtocol: class {
    func configureView()
    func openLoginViewController()
    func getAgreement()
    func setupAgreement(with url: String)
}

class RegistrationPresenter: RegistrationPresenterProtocol {
    
    weak var view: RegistrationViewControllerProtocol!
    var interactor: RegistrationInteractorProtocol!
    var router: RegistrationRouterProtocol!

    required init(view: RegistrationViewControllerProtocol) {
        self.view = view
    }
    
    func openLoginViewController() {
        router.openLoginViewController()
    }
    
    func getAgreement() {
        interactor.requestAgrementUrl()
    }
    
    func setupAgreement(with url: String) {
        view.setupAgreement(with: url)
    }
    
    
    func configureView() {
        view.setupView()
        view.setupGestures()
        getAgreement()
    }
}
