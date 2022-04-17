//
//  UserProfileConfigurator.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 06.04.2021.
//

import UIKit

class UserProfileConfigurator: UserProfileConfiguratorProtocol {
    func configure(with viewController: UserProfileViewController) {
        let presenter = UserProfilePresenter(view: viewController)
        let interactor = UserProfileInteractor(presenter: presenter)
        let router = UserProfileRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
