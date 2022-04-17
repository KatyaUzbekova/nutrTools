//
//  LoginConfigurator.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 24.05.2021.
//

import Foundation

protocol LoginConfiguratorProtocol {
    func configure(with viewController: LoginViewController)
}


class LoginConfigurator: LoginConfiguratorProtocol {
        func configure(with viewController: LoginViewController) {
            let presenter = LoginPresenter(view: viewController)
            let interactor = LoginInteractor(presenter: presenter)
            let router = LoginRouter(viewController: viewController)
            
            viewController.presenter = presenter
            presenter.interactor = interactor
            presenter.router = router
        }
}
