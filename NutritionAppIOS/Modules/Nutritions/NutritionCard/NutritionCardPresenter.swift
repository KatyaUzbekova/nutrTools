//
//  NutritionCardPresenter.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 16.04.2021.
//

import Foundation

class NutritionCardPresenter: NutritionCardPresenterProtocol {
    var router: NutritionCardRouterProtocol!
    
    func setupGestures() {
        router.setupGestures()
    }
    
    func configureView() {
        view.setupGestures()
        view.dataSetup()
        
        ApiService.shared.getNutritionistData(with: view.id){
            data, error in
            if data != nil {
                self.view.setupAboutField(with: data!.about ?? "")
                self.view.setupIsAlreadyBooked(with: data!.alreadyBooked ?? false)
            }

        }
    }
    func bookNewNurtionist() {
        ApiService.shared.postBookNewNutritionistJson(with: view.id, completion: {data,_ in
        })
    }
    func closeCurrentWindow() {
        router.closeCurrentWindow()
    }
    
    weak var view: NutritionCardViewControllerProtocol!
    var interactor: NutritionCardInteractorProtocol!
    required init(view: NutritionCardViewControllerProtocol) {
        self.view = view
    }
}
