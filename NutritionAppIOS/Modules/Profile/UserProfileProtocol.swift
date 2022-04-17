//
//  UserProfileProtocol.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 11.04.2021.
//

import UIKit

protocol UserProfilePresenterProtocol: class {
    var router: UserProfileRouterProtocol! { set get }
    func configureView()
    func openSettings()
    func openReports()
    func openMeasurements()
    func openNutritions()
    func openCameraToSelectPhoto()
    func postNewAvatar(with image: UIImage)
    func openTrasformations()
    func setupName(with name: String)
    func setupEmail(with email: String)
    func setupCoins(with coints: String)
    func setupDB(with dateBirth: String)
    func setupAvatar(isMale: Bool, link: String?)
}

protocol UserProfileInteractorProtocol: class {
    var userName: String { get }
    func setupData()
    var userEmail: String { get }
    var userCoins: String { get }
    var userDB: String { get }
}

protocol UserProfileRouterProtocol: class {
    func openSettingsViewController()
    func openReportsController()
    func openMeasurementsController()
    func openCalculatorViewController()
    func openNutritionWorkViewController()
    func openTransformationController()
}


protocol UserProfileViewProtocol: class {
    func setUserName(with name: String)
    func setUserEmail(with email: String)
    func setUserAvatar(with link: String?, placeholder: String)
    func setUserDateOfBirth(with dateOfBD: String)
    func setUserBackgroundPhoto(with link: String?)
    func setUserCoins(with coinsNumber: String)
    func setupGestures()
    func setupGradientView()
    var picker:ImagePicker! {set get}
    var view: UIView!  {set get}
}


protocol UserProfileConfiguratorProtocol: class {
    func configure(with viewController: UserProfileViewController)
}
