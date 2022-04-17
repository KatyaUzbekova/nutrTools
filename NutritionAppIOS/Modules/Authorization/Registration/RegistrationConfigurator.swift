//
//  RegistrationConfigurator.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 13.05.2021.
//

import Foundation


protocol RegistrationConfiguratorProtocol {
    func configure(with viewController: RegistrationViewController)
}


class RegistrationConfigurator: RegistrationConfiguratorProtocol {
        func configure(with viewController: RegistrationViewController) {
            let presenter = RegistrationPresenter(view: viewController)
            let interactor = RegistrationInteractor(presenter: presenter)
            let router = RegistrationRouter(viewController: viewController)
            
            viewController.presenter = presenter
            presenter.interactor = interactor
            presenter.router = router
        }
}
