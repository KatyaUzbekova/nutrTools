//
//  NutritionMainViewController.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 15.04.2021.
//

import UIKit

class NutritionMainViewController: UIViewController {
    var presenter: NutritionMainPresenterProtocol!
    let configurator: NutritionMainConfiguratorProtocol = NutritionMainConfigurator()
    
    @IBOutlet weak var gradientView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    @objc func openMyNutrition(_ sender: UITapGestureRecognizer? = nil) {
        presenter.openMyNutrition()
    }
    
    @objc func chooseNewNutrition(_ sender: UITapGestureRecognizer? = nil) {
        presenter.openNutritionSelection()
    }
    
    @IBAction func cancelSubscription(_ sender: Any) {
        presenter.cancelSubscription()
    }
    @IBOutlet weak var choseNutritionView: UIImageView!
    @IBOutlet weak var myNutritionsView: UIImageView!
    
    func setupGradientView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.gradientView!.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, CGColor(red: 35/255, green: 39/255, blue: 39/255, alpha: 1)]
        
        gradientView!.layer.mask = gradientLayer
    }
    func setupGestures() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(openMyNutrition(_:)))
        myNutritionsView.addGestureRecognizer(tap)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(chooseNewNutrition(_:)))
        choseNutritionView.addGestureRecognizer(tap2)
    }
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        presenter.closeWindow()
    }
}
