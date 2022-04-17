//
//  TransformationCreationPresenter.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 24.04.2021.
//

import UIKit

class TransformationCreationPresenter: TransformationCreationPresenterProtocol{
    weak var view: TransformationCreationViewControllerProtocol!
    var interactor: TransformationCreationInteractorProtocol!
    var router: TransformationCreationRouterProtocol!
    
    
    required init(view: TransformationCreationViewControllerProtocol) {
        self.view = view
    }
    
    func presenterAlert(with message: String) {
        router.presenterAlert(with: message)
    }
    
    func createNewTransformation(_ images: [UIImage], text: String) {
        interactor.createNewTransformation(images: images, text: text)
    }
    
    func openCameraToSelectPhotos() {
        view.picker = ImagePicker(presentationController: view as! UIViewController, delegate: view as! ImagePickerDelegate)
        view.picker.present(from: view.view)
    }
    
    func closeCurrentWindow() {
        router.closeCurrentWindow()
    }
    
    func configureView() {
        view.setupGestures()
        view.initialSetup(borderWidth: CGFloat(1.0), borderColor: UIColor.lightGray.cgColor)
    }
    
}


