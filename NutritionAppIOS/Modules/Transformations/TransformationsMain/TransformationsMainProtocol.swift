//
//  TransformationsMainProtocol.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 24.04.2021.
//

import Foundation


// View
protocol TransformationsMainViewControllerProtocol: class {
    func setupGestures()
}

// Router
protocol TransformationsMainRouterProtocol: class {
    func closeCurrentWindow()
}

// Interactor
protocol TransformationsMainInteractorProtocol: class {
}


// Configurator
protocol TransformationsMainConfiguratorProtocol: class {
}


// Presenter
protocol TransformationsMainPresenterProtocol: class {
    func configureView()
}

