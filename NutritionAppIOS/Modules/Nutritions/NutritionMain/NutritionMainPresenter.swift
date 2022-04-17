//
//  NutritionMainPresenter.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 15.04.2021.
//

import Foundation


class NutritionMainPresenter: NutritionMainPresenterProtocol {
    weak var view: NutritionMainViewController!
    var interactor: NutritionMainInteractorProtocol!
    var router: NutrtitionMainRouterProtocol!
    
    required init(view: NutritionMainViewController) {
        self.view = view
    }
    func configureView() {
        view.setupGestures()
        view.setupGradientView()
    }
    func closeWindow() {
        router.closeCurrentViewController()
    }
    func openMyNutrition() {
        router.openMyNutritions()
    }
    func cancelSubscription() {
        router.openStopSubscription()
    }
    func openNutritionSelection() {
        router.openNutritionSelection()
    }
}
