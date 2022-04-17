//
//  ReportsPresenter.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 08.04.2021.
//

import UIKit


protocol ReportsPresenterProtocol: class {
    var router: ReportsRouterProtocol! { set get }
    func configureView()
    func closeButtonClicked()
    func createNewReportsClicked()
    func reloadTableView()
}

class ReportsPresenter: ReportsPresenterProtocol {
    func createNewReportsClicked() {
        router.createNewReportController()
    }
    
    
    weak var view: ReportsViewControllerProtocol!
    var interactor: ReportsInteractorProtocol!
    var router: ReportsRouterProtocol!
    
    required init(view: ReportsViewControllerProtocol) {
        self.view = view
    }
        
    func reloadTableView() {
        router.reloadTableView()
    }
    func configureView() {
        view.setupGestures()
        view.setupGradientView()
        reloadTableView()
    }
    
    func closeButtonClicked() {
        router.closeCurrentViewController()
    }
}
