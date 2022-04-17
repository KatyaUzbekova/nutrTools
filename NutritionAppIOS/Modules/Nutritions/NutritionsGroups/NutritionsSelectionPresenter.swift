//
//  NutritionsSelectionPresenter.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 21.04.2021.
//

import UIKit

class NutritionsSelectionPresenter: NutritionsSelectionPresenterProtocol {
    var router: NutritionSelectionRouterProtocol!

    func configureView() {
        view.setupGradienLayer(with: setupGradientView())
        view.setupGestures()
        view.tableViewPreSetup()
        ApiService.shared.getAllNutritionistRequest(){
            data,_ in
            if data != nil {
                self.view.tableDataSetup(with: data!.array)
            }
        }
    }
    
    func closeCurrentWindow() {
        router.closeCurrentWindow()
    }
    
    func setupGradientView() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.gradientView!.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, CGColor(red: 35/255, green: 39/255, blue: 39/255, alpha: 1)]
        return gradientLayer
    }
    
    func setupGestures() {
    }
    
    weak var view: NutritionSelectionViewControllerProtocol!
    var interactor: NutritionsSelectionInteractorProtocol!
    required init(view: NutritionSelectionViewControllerProtocol) {
        self.view = view
    }
}
