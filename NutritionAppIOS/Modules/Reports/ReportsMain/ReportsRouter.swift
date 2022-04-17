//
//  ReportsRouter.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 08.04.2021.
//


import UIKit

protocol ReportsRouterProtocol: class {
    func closeCurrentViewController()
    func createNewReportController()
    func reloadTableView()
}


class ReportsRouter: ReportsRouterProtocol {
    func createNewReportController() {
        let cl = (viewController.storyboard?.instantiateViewController(withIdentifier: "reportsAdditionViewController") as! ReportsAdditionViewController)
        viewController.present(cl, animated: true, completion: nil)
    }
    
    func reloadTableView() {
        viewController.allReports = []
        viewController.reloadTableView()
        
        ApiService.shared
            .getAllReportsJson{ [self]data,error in
                if data != nil {
                    viewController.setHiddenLabel(with: data!.array.count == 0)
                    if data!.array.count > 0 {
                        viewController.setupBackgroundPhoto(with: UIImage(named: "notZeroReports")!)
                    }
                    viewController.allReports = data!.array
                    
                    viewController.reloadTableView()
                }
                else {
                    viewController.showToast(message: error?.localizedDescription ?? "Error with internet connection", seconds: 0.4)
                }
            }
    }
    weak var viewController: ReportsViewController!
    
    init(viewController: ReportsViewController) {
        self.viewController = viewController
    }
    
    func closeCurrentViewController() {
        viewController.dismiss(animated: true, completion: nil)
    }
}
