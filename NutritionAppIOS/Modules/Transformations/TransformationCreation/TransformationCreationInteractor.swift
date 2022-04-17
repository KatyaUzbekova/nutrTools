//
//  TransformationCreationInteractor.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 24.04.2021.
//

import UIKit

class TransformationCreationInteractor: TransformationCreationInteractorProtocol {
    weak var presenter:  TransformationCreationPresenterProtocol!
    
    required init(presenter: TransformationCreationPresenterProtocol) {
        self.presenter = presenter
    }
    
    func createNewTransformation(images: [UIImage], text: String) {
        ApiService.shared.createNewTransformationRequest(images: images, text: text, completion: {
            data,error in
            if let safeData = data {
                NotificationCenter.default.post(name: NSNotification.Name("reloadTransformations"), object: nil)
                self.presenter.presenterAlert(with: safeData.message!)
            }
        })
    }

}
