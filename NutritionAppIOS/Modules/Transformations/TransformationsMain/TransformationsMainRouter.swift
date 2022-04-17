//
//  TransformationsMainRouter.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 24.04.2021.
//

import Foundation

class TransformationsMainRouter: TransformationsMainRouterProtocol{
    
    weak var viewController: TransformationsMainViewController!
    
    init(viewController: TransformationsMainViewController) {
        self.viewController = viewController
    }
    
    
    func closeCurrentWindow() {
        viewController.dismiss(animated: true, completion: nil)
    }
}
