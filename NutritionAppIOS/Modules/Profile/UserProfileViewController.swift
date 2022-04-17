//
//  UserProfileViewController.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 06.04.2021.
//

import UIKit

class UserProfileViewController: UIViewController, UserProfileViewProtocol{
    @objc func openReports(_ sender: UITapGestureRecognizer? = nil) {
        presenter.openReports()
    }
    
    
    @objc func openMeasurements(_ sender: UITapGestureRecognizer? = nil) {
        presenter.openMeasurements()
    }
    
    @objc func openTransformations(_ sender: UITapGestureRecognizer? = nil) {
        presenter.openTrasformations()
    }
    
    @objc func openNutritions(_ sender: UITapGestureRecognizer? = nil) {
        presenter.openNutritions()
    }
    
    
    @objc func setupAvatar(_ sender: UITapGestureRecognizer? = nil) {
        presenter.openCameraToSelectPhoto()
    }
    
    func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(openReports(_:)))
        myMesurement2.addGestureRecognizer(tap)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(openMeasurements(_:)))
        myMeasurement1.addGestureRecognizer(tap2)
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(openNutritions(_:)))
        workWithNutritionView.addGestureRecognizer(tap3)
        
        let setupNewAvatar = UITapGestureRecognizer(target: self, action: #selector(setupAvatar(_:)))
        userAvatar.addGestureRecognizer(setupNewAvatar)
        
        let openTrasformations = UITapGestureRecognizer(target: self, action: #selector(openTransformations(_:)))
        myMeasurement3.addGestureRecognizer(openTrasformations)
        
    }
    
    func setUserCoins(with coinsNumber: String) {
        userCoins.text = coinsNumber
    }
    
    func setUserEmail(with email: String) {
        userEmail.text = email
    }
    
    func setUserAvatar(with link: String?, placeholder: String) {
        if let safeLink = link {
            setNewImage(linkToPhoto: "\(urlToImage)\(safeLink)", imageInput: userAvatar, isRounded: true, placeholderPic: placeholder)
        }
    }
    
    func setUserDateOfBirth(with dateOfBD: String) {
        userDateOfBirth.text = dateOfBD
    }
    
    func setUserBackgroundPhoto(with link: String?) {
        if let safeLink = link {
            setNewImage(linkToPhoto: "\(urlToImage)\(safeLink)", imageInput: userBackgroundPhoto)
        }
    }
    
    func setUserName(with name: String) {
        userName.text = name
    }
    
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userDateOfBirth: UILabel!
    @IBOutlet weak var userBackgroundPhoto: UIImageView!
    @IBOutlet weak var userCoins: UILabel!
    
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var workWithNutritionView: UIImageView!
    @IBAction func settingsButton(_ sender: Any) {
        presenter.openSettings()
    }
    var picker: ImagePicker!

    @IBOutlet weak var myMeasurement1: UIImageView!
    
    @IBOutlet weak var myMesurement2: UIImageView!
    
    @IBOutlet weak var myMeasurement3: UIImageView!
    
    var presenter: UserProfilePresenterProtocol!
    let configurator: UserProfileConfiguratorProtocol = UserProfileConfigurator()
    
    func setupGradientView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.gradientView!.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, CGColor(red: 35/255, green: 39/255, blue: 39/255, alpha: 1)]
        
        gradientView!.layer.mask = gradientLayer
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        presenter.configureView()
    }
}


extension UserProfileViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        if let imageExist = image {
            userAvatar.image = imageExist
            userBackgroundPhoto.image = imageExist
            presenter.postNewAvatar(with: imageExist)
        }
    }
}
