//
//  LoginViewController.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 13.05.2021.
//

import UIKit

protocol LoginViewControllerProtocol: class {
    func setupView()
    func setupGestures()
    func showErrorAllert()
}

class LoginViewController: UIViewController, LoginViewControllerProtocol {
    
    func showErrorAllert() {
        self.showToast(message: NSLocalizedString("CheckDataCorrectness", comment: "no check data correctness"), seconds: 0.6)
    }

    
    @IBOutlet weak var forgetPasswordLabel: UILabel!
    @IBOutlet weak var registrationLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var showPasswordImage: UIImageView!
    
    @IBAction func logInAction() {
        let parameters = ["email": emailTextField.text ?? "",
                          "fcmToken": AppDelegate.fcmToken,
                          "password": passwordTextField.text ?? ""]
        presenter.logInAction(with: parameters)
    }
    
    @objc func openRegistrationViewController(_ sender: UITapGestureRecognizer? = nil) {
        presenter.openRegistrationViewController()
    }
    @objc func showPassword(_ sender: UITapGestureRecognizer? = nil) {
        if passwordTextField.isSecureTextEntry {
            showPasswordImage.image = UIImage(systemName: "eye")
        }
        else {
            showPasswordImage.image = UIImage(named: "eyePassword")
        }
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(openRegistrationViewController(_:)))
        registrationLabel.addGestureRecognizer(tap)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(showPassword(_:)))
        showPasswordImage.addGestureRecognizer(tap2)
    }
    
    func setupView() {
        hideKeyboardWhenTappedAround()
    }
    
    var presenter: LoginPresenterProtocol!
    let configurator: LoginConfiguratorProtocol = LoginConfigurator()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        presenter.configureView()
    }
}
