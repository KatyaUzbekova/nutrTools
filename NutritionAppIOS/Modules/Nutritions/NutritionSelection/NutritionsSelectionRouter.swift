//
//  NutritionsSelectionRouter.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 21.04.2021.
//

import Foundation

class NutritionSelectionRouter: NutritionSelectionRouterProtocol {
    func setupGestures() {
    }
    
    func closeCurrentWindow() {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    weak var viewController: NutritionSelectionViewController!
    
    init(viewController: NutritionSelectionViewController) {
        self.viewController = viewController
    }
}
