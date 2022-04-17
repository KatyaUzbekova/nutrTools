//
//  NameGenderViewController.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 11.05.2021.
//

import UIKit
import SwiftKeychainWrapper
import Starscream


protocol RegistrationViewControllerProtocol: class {
    func setupView()
    func setupGestures()
    func setupAgreement(with url: String)
    
}

class RegistrationViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var agreementTextView: UITextView!
    @IBOutlet weak var agreementButton: UIButton!
    @IBOutlet weak var registrationNameAndGenderView: UIView!
    @IBOutlet weak var registrationOfBirth: UIView!
    @IBOutlet weak var registrationEmailPasswordView: UIView!
    @IBOutlet weak var dateOfBirth: UITextField!
    @IBOutlet weak var genderTableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var logInView: UILabel!
    @IBOutlet weak var showHidePasswordView: UIImageView!
    

    func setupAgreement(with url: String) {
        self.agreementTextView.hyperLink(originalText: NSLocalizedString("RegistrationViewController.Label.Agreement", comment: "Agreeement Full Text Label"), hyperLink: NSLocalizedString("RegistrationViewController.Text.AgreementName", comment: "Agreeement name")  , urlString: url)
    }
    @IBAction func agreementCheck(_ sender: Any) {
        agreementButton.setImage(UIImage(named: "acceptedRound"), for: .normal)
        agreementButton.isEnabled = false
    }
    
    var userDatas = [String:Any]()
    var regStep = 1
    
    @IBAction func contunueButtonAction(_ sender: Any) {
        switch regStep {
        case 1:
            if nameTextField.text != "" && selectedGender != nil {
                
                userDatas["name"] = nameTextField.text!
                registrationNameAndGenderView.isHidden = true
                registrationOfBirth.isHidden = false
                registrationEmailPasswordView.isHidden = true
                regStep = 2
            }
            else {
                self.showToast(message: NSLocalizedString("RegistrationViewController.Alert.FillAllTheSpaces", comment: "Fill the spaces, please"), seconds: 0.4)
            }
            break
        case 2:
            if dateOfBirth.text != "" {
                userDatas["birthDate"] = dateOfBirth.text!
                registrationNameAndGenderView.isHidden = true
                registrationOfBirth.isHidden = true
                registrationEmailPasswordView.isHidden = false
                regStep = 3
                continueButton.setTitle(NSLocalizedString("RegistrationViewController.Action.CreateAnAccount", comment: "make new account"), for: .normal)
            }
            break
        default:
            if emailTextField.text != "" &&  passwordTextField.text != "" {
                userDatas["email"] = emailTextField.text!
                userDatas["password"] =  passwordTextField.text!
                completeRegistration()
            }
            break
        }
        
    }
    
    func completeRegistration() {
        userDatas["fcmToken"] = AppDelegate.fcmToken
        userDatas["userAgreementAccepted"] = true
        ApiService.shared.registrationRequest(parameters: userDatas) {data,error in
            if let safeData = data {
                if let checkedBody = safeData.body {
                    UserDefaults.standard.setValue(0, forKey: "WaterBalanceSelected")
                    let accessToken = checkedBody.token
                    KeychainWrapper.standard.set(accessToken, forKey: "accessToken")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
                    self.present(vc, animated: true)
                }
                else {
                    self.showToast(message: safeData.message!, seconds: 2)
                }
            }
        }
    }
    
    @objc func openLoginViewController(_ sender: UITapGestureRecognizer? = nil) {
        presenter.openLoginViewController()
    }
    
    @objc func showHidePassword(_ sender: UITapGestureRecognizer? = nil) {
        print("SHOW HIDE")
        if passwordTextField.isSecureTextEntry {
            showHidePasswordView.image = UIImage(systemName: "eye")
        }
        else {
            showHidePasswordView.image = UIImage(named: "eyePassword")
        }
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
    
    func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(openLoginViewController(_:)))
        logInView.addGestureRecognizer(tap)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(showHidePassword(_:)))
        showHidePasswordView.addGestureRecognizer(tap2)
    }
    
    var presenter: RegistrationPresenterProtocol!
    let configurator: RegistrationConfiguratorProtocol = RegistrationConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        presenter.configureView()
    }
    let genders = [NSLocalizedString("Genders.Woman", comment: "Women"), NSLocalizedString("Genders.Man", comment: "Men")]
    var selectedGender: Int?
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == dateOfBirth {
            if dateOfBirth.text?.count == 2 || dateOfBirth.text?.count == 5 {
                if !(string == "") {
                    dateOfBirth.text = dateOfBirth.text! + "-"
                }
            }
            return !(textField.text!.count > 9 && (string.count ) > range.length)
        } else {
            return true
        }
    }
}

extension RegistrationViewController: RegistrationViewControllerProtocol {
    
    func setupView() {

        
        dateOfBirth.delegate = self
        genderTableView.delegate = self
        genderTableView.dataSource = self
        hideKeyboardWhenTappedAround()
    }
}

extension RegistrationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        genders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : GenderCell! = (tableView.dequeueReusableCell(withIdentifier: "genderTableViewCell") as! GenderCell)
        
        if let safeSelectedGender = selectedGender {
            if indexPath.row == safeSelectedGender {
                cell.genderCell = true
            }
            else {
                cell.genderCell = false
            }
        }
        else {
            cell.genderCell = false
        }
        cell.genderLabel.text = genders[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let _ : GenderCell! = (tableView.dequeueReusableCell(withIdentifier: "genderTableViewCell") as! GenderCell)
        userDatas["isMale"] =  indexPath.row == 1
        selectedGender = indexPath.row
        DispatchQueue.main.async {
            self.genderTableView.reloadData()
        }
    }
}


class GenderCell: UITableViewCell {
    @IBOutlet weak var radioButton: UIImageView!
    @IBOutlet weak var genderLabel: UILabel!
    var genderCell: Bool! {
        didSet {
            if genderCell {
                radioButton.image = UIImage(named: "acceptedRound")
            }
            else {
                radioButton.image = UIImage(named: "nonAcceptedRound")
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


extension UITextView {
    func hyperLink(originalText: String, hyperLink: String, urlString: String) {
        let attributedOriginalText = NSMutableAttributedString(string: originalText)
        let linkRange = attributedOriginalText.mutableString.range(of: hyperLink)
        let fullRange = NSMakeRange(0, attributedOriginalText.length)
        attributedOriginalText.addAttribute(NSAttributedString.Key.link, value: urlString, range: linkRange)
        attributedOriginalText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: fullRange)
        attributedOriginalText.addAttribute(NSAttributedString.Key.font, value:  UIFont(name: "AvenirNext-Regular", size: 10)!, range: fullRange)
        attributedOriginalText.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.thick.rawValue, range: linkRange)
        
        self.linkTextAttributes = [
            kCTForegroundColorAttributeName: UIColor.blue,
            kCTUnderlineStyleAttributeName: NSUnderlineStyle.single.rawValue,
        ] as [NSAttributedString.Key : Any]
        self.attributedText = attributedOriginalText
    }
}


