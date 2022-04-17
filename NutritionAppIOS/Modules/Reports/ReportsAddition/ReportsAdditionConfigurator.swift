//
//  ReportsAdditionConfigurator.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 09.04.2021.
//

import Foundation

protocol ReportsAdditionConfiguratorProtocol: class {
    func configure(with viewController: ReportsAdditionViewController)
}

class ReportsAdditionConfigurator: ReportsAdditionConfiguratorProtocol {
    func configure(with viewController: ReportsAdditionViewController) {
        let presenter = ReportsAdditionPresenter(view: viewController)
        let interactor = ReportsAdditionInteractor(presenter: presenter)
        let router = ReportsAdditionRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
