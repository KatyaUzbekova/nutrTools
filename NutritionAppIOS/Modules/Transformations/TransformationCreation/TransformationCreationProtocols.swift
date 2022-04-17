//
//  TransformationCreationProtocol.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 24.04.2021.
//

import UIKit

// Configurator
protocol TransformationCreationConfiguratorProtocol: class {
    func configure(with viewController: TransformationCreationViewController)
}

// Presenter
protocol TransformationCreationPresenterProtocol: class {
    func openCameraToSelectPhotos()
    func configureView()
    var router: TransformationCreationRouterProtocol! { set get }
    func closeCurrentWindow()
    func createNewTransformation(_ images: [UIImage], text: String)
    func presenterAlert(with message: String) 
}

// View
protocol TransformationCreationViewControllerProtocol: class {
    func setupGestures()
    func initialSetup(borderWidth: CGFloat, borderColor: CGColor)
    var picker:ImagePicker! {set get}
    var view: UIView!  {set get}
}

// Router
protocol TransformationCreationRouterProtocol: class {
    func closeCurrentWindow()
    func presenterAlert(with message: String)
    
}

// Interactor
protocol TransformationCreationInteractorProtocol: class {
    func createNewTransformation(images: [UIImage], text: String)
}

