//
//  ReportsConfigurator.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 08.04.2021.
//

protocol ReportsConfiguratorProtocol: class {
    func configure(with viewController: ReportsViewController)
}

class ReportsConfigurator: ReportsConfiguratorProtocol {
    func configure(with viewController: ReportsViewController) {
        let presenter = ReportsPresenter(view: viewController)
        let interactor = ReportsInteractor(presenter: presenter)
        let router = ReportsRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
