//
//  MainTabBarController.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 06.04.2021.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.layer.masksToBounds = true
        tabBar.layer.cornerRadius = 18
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.frame = CGRect(x: (tabBar.frame.width-view.frame.width+27*2)/2, y: view.frame.height-81, width: view.frame.width-27*2, height: 57)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

    
}
