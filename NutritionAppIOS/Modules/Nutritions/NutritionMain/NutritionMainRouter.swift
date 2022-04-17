//
//  NutritionMainRouter.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 15.04.2021.
//

import Foundation

class NutritionMainRouter: NutrtitionMainRouterProtocol {
    
    private let nutritionSelectionId = "FindYourNutritionVIew"
    
    private let myNutritionsId = "activated"
    private let stopSubscriptionsId = ""
    
    func closeCurrentViewController() {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func openNutritionSelection() {
        let nextController = viewController.storyboard?.instantiateViewController(withIdentifier: nutritionSelectionId) as! NutritionSelectionViewController
        viewController.present(nextController, animated: true, completion: nil)
    }
    
    func openMyNutritions() {
        let nextController = (viewController.storyboard?.instantiateViewController(withIdentifier: myNutritionsId))!
        viewController.present(nextController, animated: true, completion: nil)
    }
    
    func openStopSubscription() {
        //TODO: realize stop subscription
    }
    
    weak var viewController: NutritionMainViewController!
    init(viewController: NutritionMainViewController) {
        self.viewController = viewController
    }
}
