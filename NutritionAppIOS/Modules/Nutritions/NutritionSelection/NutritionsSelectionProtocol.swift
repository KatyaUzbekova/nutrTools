//
//  NutritionsSelectionProtocol.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 21.04.2021.
//

import UIKit

protocol NutritionSelectionViewControllerProtocol: class {
    func reloadData()
    func setupGradienLayer(with layer: CAGradientLayer)
    var gradientView: UIView! {set get}
    func setupGestures()
    func tableDataSetup(with data: [SingleNutritionist])
    func tableViewPreSetup()
}

protocol NutritionSelectionRouterProtocol: class {
    func setupGestures()
    func closeCurrentWindow()
}

protocol NutritionsSelectionPresenterProtocol: class {
    var router: NutritionSelectionRouterProtocol! { set get }
    func configureView()
    func closeCurrentWindow()
    func setupGestures()
}

protocol NutritionsSelectionConfiguratorProtocol: class {
    func configure(with viewController: NutritionSelectionViewController)
}

protocol NutritionsSelectionInteractorProtocol: class {
    
}
