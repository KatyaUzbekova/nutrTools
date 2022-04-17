//
//  NutritionsSelectionConfigurator.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 21.04.2021.
//

import Foundation


class NutritionsSelectionConfigurator: NutritionsSelectionConfiguratorProtocol {
        func configure(with viewController: NutritionSelectionViewController) {
            let presenter = NutritionsSelectionPresenter(view: viewController)
            let interactor = NutritionsSelectionInteractor(presenter: presenter)
            let router = NutritionSelectionRouter(viewController: viewController)
            
            viewController.presenter = presenter
            presenter.interactor = interactor
            presenter.router = router
        }
}
