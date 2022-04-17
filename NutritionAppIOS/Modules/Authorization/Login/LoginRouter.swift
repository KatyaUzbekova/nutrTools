//
//  LoginRouter.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 24.05.2021.
//

import UIKit


protocol LoginRouterProtocol: class {
    func showMainTabBarController()
    func openRegistrationViewController()
}

class LoginRouter: LoginRouterProtocol {
    weak var viewController: LoginViewController!
    
    private let mainTabBarId = "MainTabBarController"
    private let registrationId = "RegistrationViewController"

    func showMainTabBarController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: mainTabBarId) as! MainTabBarController
        viewController.present(vc, animated: true)
    }
    
    func openRegistrationViewController() {
        let storyboard = UIStoryboard(name: "Authorization", bundle: nil)
        let cl = storyboard.instantiateViewController(withIdentifier: registrationId) as! RegistrationViewController
        viewController.present(cl, animated: false, completion: nil)
    }
    
    init(viewController: LoginViewController) {
        self.viewController = viewController
    }
}
