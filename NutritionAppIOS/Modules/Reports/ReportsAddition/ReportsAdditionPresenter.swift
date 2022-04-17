//
//  ReportsAdditionPresenter.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 09.04.2021.
//

import UIKit


protocol ReportsAdditionPresenterProtocol: class {
    var router: ReportsAdditionRouterProtocol! { set get }
    func configureView()
    func closeButtonClicked()
    func createNewReportsClicked()
    func openCameraToSelectPhotos()
    func setNewPhoto(image: UIImage?)
}

class ReportsAdditionPresenter: ReportsAdditionPresenterProtocol {
    func openCameraToSelectPhotos() {
        view.picker = ImagePicker(presentationController: view as! UIViewController, delegate: view as! ImagePickerDelegate)
        view.picker.present(from: view.view)
    }
    func setNewPhoto(image: UIImage?) {
        if let imageExist = image {
            view.setupImage(with: imageExist)
        }
    }
    var router: ReportsAdditionRouterProtocol!
    
    func createNewReportsClicked() {
        if view.insertedText != nil && view.pickedImage != nil {
            router.createNewReportController(image: view.pickedImage!, report: view.insertedText!)
        }
    }
    
    
    weak var view: ReportsAdditionViewControllerProtocol!
    var interactor: ReportsAdditionInteractorProtocol!
    
    required init(view: ReportsAdditionViewControllerProtocol) {
        self.view = view
    }
        
    func configureView() {
        view.setupGestures()
        view.initialSetup(borderWidth: CGFloat(1.0), borderColor: UIColor.lightGray.cgColor)
    }
    
    func closeButtonClicked() {
        router.closeCurrentViewController()
    }
}

