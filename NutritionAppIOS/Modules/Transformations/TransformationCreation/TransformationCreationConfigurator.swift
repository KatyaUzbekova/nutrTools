//
//  TransformationCreationConfigurator.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 24.04.2021.
//

import Foundation


class TransformationCreationConfigurator: TransformationCreationConfiguratorProtocol{
    
    func configure(with viewController: TransformationCreationViewController) {
        let presenter = TransformationCreationPresenter(view: viewController)
        let interactor = TransformationCreationInteractor(presenter: presenter)
        let router = TransformationCreationRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }

}
