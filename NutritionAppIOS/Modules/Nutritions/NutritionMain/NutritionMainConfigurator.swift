//
//  NutritionMainConfigurator.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 15.04.2021.
//

import Foundation

class NutritionMainConfigurator: NutritionMainConfiguratorProtocol {

    
    func configure(with viewController: NutritionMainViewController) {
        let presenter = NutritionMainPresenter(view: viewController)
        let interactor = NutritionMainInteractor(presenter: presenter)
        let router = NutritionMainRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
