//
//  TransformationCreationRouter.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 24.04.2021.
//

import UIKit

class TransformationCreationRouter: TransformationCreationRouterProtocol{
    
    weak var viewController: TransformationCreationViewController!
    
    init(viewController: TransformationCreationViewController) {
        self.viewController = viewController
    }
    
    
    func closeCurrentWindow() {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func presenterAlert(with message: String) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alertController.title = message
        
        alertController.addAction(UIAlertAction(title: NSLocalizedString("TransformationCreationRouter.Ok", comment: "Ok"), style: .cancel) {_ in
        })
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = self.viewController.view
            alertController.popoverPresentationController?.sourceRect = self.viewController.view.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }

        DispatchQueue.main.async {
            self.viewController.present(alertController, animated: true)
        }
    }
}
