//
//  UserProfilePresenter.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 06.04.2021.
//

import Foundation
import UIKit


class UserProfilePresenter: UserProfilePresenterProtocol{

    
    func openNutritions() {
        router.openNutritionWorkViewController()
    }
    
    
    weak var view: UserProfileViewProtocol!
    var interactor: UserProfileInteractorProtocol!
    var router: UserProfileRouterProtocol!

    required init(view: UserProfileViewProtocol) {
        self.view = view
    }
    
    func openSettings() {
        router.openSettingsViewController()
    }
    
    func openReports() {
        router.openReportsController()
    }
    
    func openMeasurements() {
        router.openMeasurementsController()
    }
    
    func openTrasformations() {
        router.openTransformationController()
    }
    func openCameraToSelectPhoto() {
        view.picker = ImagePicker(presentationController: view as! UIViewController, delegate: view as! ImagePickerDelegate)
        view.picker.present(from: view.view)
    }
    func postNewAvatar(with image: UIImage) {
        ApiService.shared.postSetAvatarRequest(image: image, completion: {_,_ in})
    }
    
    
    func setupName(with name: String) {
        self.view.setUserName(with: name)
    }
    
    func setupEmail(with email: String) {
        self.view.setUserEmail(with: email)
    }
    
    func setupCoins(with coints: String) {
        self.view.setUserCoins(with: coints)
    }
    
    func setupDB(with dateBirth: String) {
        self.view.setUserDateOfBirth(with: dateBirth)
    }
    
    func setupAvatar(isMale: Bool, link: String?) {
        if isMale {
            self.view.setUserAvatar(with: link, placeholder: "male_mock_avatar")
        }
        else {
            self.view.setUserAvatar(with: link, placeholder: "female_mock_avatar")
        }
        
        self.view.setUserBackgroundPhoto(with: link)

    }
    
    func configureView() {
        view.setupGradientView()
        view.setupGestures()
    }
}
