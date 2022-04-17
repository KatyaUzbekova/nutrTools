//
//  LoginPresenter.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 24.05.2021.
//

import UIKit
import SwiftKeychainWrapper

protocol LoginPresenterProtocol: class {
    func configureView()
    func openRegistrationViewController()
    func logInAction(with parameters: [String: String])
}

class LoginPresenter: LoginPresenterProtocol {
    
    weak var view: LoginViewControllerProtocol!
    var interactor: LoginInteractorProtocol!
    var router: LoginRouterProtocol!
    
    required init(view: LoginViewControllerProtocol) {
        self.view = view
    }
    
    func logInAction(with parameters: [String: String]) {
        ApiService.shared.logInUserRequest(parameters: parameters){data,err in
            if let safeData = data {
                if let checkedBody = safeData.body {
                    let accessToken = checkedBody.token
                    KeychainWrapper.standard.set(accessToken, forKey: "accessToken")
                    UserDefaults.standard.setValue(0, forKey: "WaterBalanceSelected")
                    self.router.showMainTabBarController()
                }
                else {
                    self.view.showErrorAllert()
                }
            }
            else {
                self.view.showErrorAllert()
            }
        }
    }
    func openRegistrationViewController() {
        router.openRegistrationViewController()
    }
    
    func configureView() {
        view.setupView()
        view.setupGestures()
    }
}
