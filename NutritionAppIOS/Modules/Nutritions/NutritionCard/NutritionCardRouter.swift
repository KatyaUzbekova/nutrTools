//
//  NutritionCardRouter.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 16.04.2021.
//

import UIKit

class NutritionCardRouter: NutritionCardRouterProtocol {
    func setupGestures() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleDismissGesture))
        swipeRight.direction = .right
        self.viewController.view.addGestureRecognizer(swipeRight)
    }
    
    func closeCurrentWindow() {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    weak var viewController: NutritionCardViewController!
    
    init(viewController: NutritionCardViewController) {
        self.viewController = viewController
    }
    
    @objc private func handleDismissGesture(gesture: UISwipeGestureRecognizer) -> Void {
        closeCurrentWindow()
    }
    
}
