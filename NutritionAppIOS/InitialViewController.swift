//
//  InitialViewController.swift
//  
//
//  Created by Екатерина Узбекова on 25.05.2021.
//

import UIKit
import SwiftKeychainWrapper

class InitialViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if KeychainWrapper.standard.string(forKey: "accessToken") != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
            self.present(initialViewController, animated: true, completion: nil)
        }
        else {
            let storyboard = UIStoryboard(name: "Authorization", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
            self.present(initialViewController, animated: true, completion: nil)
        }
    }
}
