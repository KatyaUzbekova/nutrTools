//
//  NutritionCardConfigurator.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 16.04.2021.
//

import Foundation

class NutritionCardConfigurator: NutritionCardConfiguratorProtocol {
    func configure(with viewController: NutritionCardViewController) {
        let presenter = NutritionCardPresenter(view: viewController)
        let interactor = NutritionCardInteractor(presenter: presenter)
        let router = NutritionCardRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
