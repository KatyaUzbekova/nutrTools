//
//  ReportsAdditionRouter.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 09.04.2021.
//

import UIKit

protocol ReportsAdditionRouterProtocol: class {
    func closeCurrentViewController()
    func createNewReportController(image: UIImage, report: String)
}


class ReportsAdditionRouter: ReportsAdditionRouterProtocol {
    weak var viewController: ReportsAdditionViewController!

    func createNewReportController(image: UIImage, report: String) {
        ApiService.shared.createNewReport(image: image, report: report, completion: {
            _,_ in
            NotificationCenter.default.post(name: NSNotification.Name("reloadReports"), object: nil)
        })
        viewController.dismiss(animated: true, completion: nil)
    }
    
    init(viewController: ReportsAdditionViewController) {
        self.viewController = viewController
    }
    
    func closeCurrentViewController() {
        viewController.dismiss(animated: true, completion: nil)
    }
}
