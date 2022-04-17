//
//  NutrtitionMainProtocol.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 15.04.2021.
//

import Foundation

protocol NutrtitionMainRouterProtocol: class {
    func closeCurrentViewController()
    func openNutritionSelection()
    func openMyNutritions()
    func openStopSubscription()
}

protocol NutritionMainConfiguratorProtocol: class {
    func configure(with viewController: NutritionMainViewController)
}

protocol NutritionMainPresenterProtocol: class {
    func configureView()
    func openMyNutrition()
    func cancelSubscription()
    func openNutritionSelection()
    func closeWindow()
}

protocol NutritionMainInteractorProtocol: class {
    
}
