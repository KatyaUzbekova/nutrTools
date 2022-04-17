//
//  RegistrationRouter.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 13.05.2021.
//

import Foundation

protocol RegistrationRouterProtocol: class {
    func openLoginViewController()
}

class RegistrationRouter: RegistrationRouterProtocol {
    let loginViewControllerId = "LoginViewController"

    weak var viewController: RegistrationViewController!
    
    init(viewController: RegistrationViewController) {
        self.viewController = viewController
    }
    
    func openLoginViewController() {
        let cl = (viewController.storyboard?.instantiateViewController(withIdentifier: loginViewControllerId) as! LoginViewController)
        viewController.present(cl, animated: false, completion: nil)
    }
}
