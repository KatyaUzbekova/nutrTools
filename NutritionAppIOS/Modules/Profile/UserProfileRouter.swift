//
//  UserProfileRouter.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 06.04.2021.
//

import Foundation

class UserProfileRouter: UserProfileRouterProtocol {
    func openCalculatorViewController() {
        print("openCalculatorViewController")
    }
    
    func openNutritionWorkViewController() {
        let cl = (viewController.storyboard?.instantiateViewController(withIdentifier: "NutritionViewController"))!
        viewController.present(cl, animated: true, completion: nil)
    }
    
    
    weak var viewController: UserProfileViewController!
    
    init(viewController: UserProfileViewController) {
        self.viewController = viewController
    }
    
    func openReportsController() {
        let nextController = (viewController.storyboard?.instantiateViewController(withIdentifier: "MyReports"))!
        viewController.present(nextController, animated: true, completion: nil)
    }
    
    func openMeasurementsController() {
        let nextController = (viewController.storyboard?.instantiateViewController(withIdentifier: "MyReports2"))!
        viewController.present(nextController, animated: true, completion: nil)
    }
    func openTransformationController(){
        let nextController = (viewController.storyboard?.instantiateViewController(withIdentifier: "TransformationsMain"))!
        viewController.present(nextController, animated: true, completion: nil)
    }
    
    func openSettingsViewController() {
        ApiService.shared.logOut()
    }
}
