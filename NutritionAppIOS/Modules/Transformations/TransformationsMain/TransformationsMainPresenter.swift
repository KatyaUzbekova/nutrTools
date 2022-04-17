//
//  TransformationsMainPresenter.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 24.04.2021.
//

import UIKit

class TransformationsMainPresenter: TransformationsMainPresenterProtocol{
    weak var view: TransformationsMainViewControllerProtocol!
    var interactor: TransformationsMainInteractorProtocol!
    var router: TransformationsMainRouterProtocol!
    
    
    required init(view: TransformationsMainViewControllerProtocol) {
        self.view = view
    }

    func closeCurrentWindow() {
        router.closeCurrentWindow()
    }
    
    func configureView() {
        view.setupGestures()
    }
    
}
