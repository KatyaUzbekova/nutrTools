//
//  NutritionCardProtocol.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 16.04.2021.
//

import Foundation

protocol NutritionCardViewControllerProtocol: class {
    func setupGestures()
    func dataSetup()
    func setupAboutField(with text: String)
    var id: String! {set get}
    func setupIsAlreadyBooked(with condition: Bool)
}

protocol NutritionCardConfiguratorProtocol: class {
    func configure(with viewController: NutritionCardViewController)
}

protocol NutritionCardRouterProtocol: class {
    func setupGestures()
    func closeCurrentWindow()
}


protocol NutritionCardPresenterProtocol: class {
    var router: NutritionCardRouterProtocol! { set get }
    func configureView()
    func closeCurrentWindow()
    func setupGestures()
    func bookNewNurtionist()
}
protocol NutritionCardInteractorProtocol: class {
}


