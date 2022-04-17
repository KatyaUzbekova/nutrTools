//
//  MeasurementsAdditionViewController.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 08.04.2021.
//

import UIKit

class MeasurementsAdditionViewController: UIViewController {
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var waist: UITextField!
    @IBOutlet weak var chest: UITextField!
    @IBOutlet weak var hip: UITextField!
    @IBOutlet weak var calve: UITextField!
    @IBOutlet weak var neck: UITextField!

    var isMoved = false
    @objc func keyboardWillShow(notification: NSNotification) {
            
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           return
        }
        if weight.isFirstResponder && isMoved == false {
            print("-")
            isMoved = true
            self.weigthLabelView.frame.origin.y = self.weigthLabelView.frame.origin.y - keyboardSize.height
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           return
        }

        if isMoved{
            self.weigthLabelView.frame.origin.y = self.weigthLabelView.frame.origin.y + keyboardSize.height
            isMoved = false
            print("+")

        }
    }
    
    func getCurrentDateSentFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    @IBAction func postMeasurement(_ sender: Any) {
        var parameters = [
            "date": getCurrentDateSentFormat()
        ]
        if neck.hasText && waist.hasText && weight.hasText {
            parameters["weight"] = weight.text!
            parameters["neck"] = neck.text!
            parameters["waist"] = waist.text!
            parameters["hip"] = hip.text ?? "0"
            parameters["calve"] = calve.text ?? "0"
            parameters["chest"] = chest.text ?? "0"

            ApiService.shared.setupNewMeasurements(parameters: parameters) {_,_ in
                NotificationCenter.default.post(name: NSNotification.Name("reloadMeasurements"), object: nil)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    func initialSetup() {
        let isMale = UserDefaults.standard.bool(forKey: "isMale")
        if isMale {
            backMeasurementsPicture.image = UIImage(named: "menMeasurements")
        }
        else {
            backMeasurementsPicture.image = UIImage(named: "womanMeasurements")
        }
        
        
        self.hideKeyboardWhenTappedAround()

    }
    @IBOutlet var backMeasurementsPicture: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        neck.delegate = self
        waist.delegate = self
        weight.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(MeasurementsAdditionViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(MeasurementsAdditionViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        initialSetup()
        setupGesture()
    }
    
    
    @IBOutlet var chestLabelView: UIView!
    @IBOutlet var chestWithData: UIView!
    @IBOutlet var chestLabel: UILabel!
    
    
    @IBOutlet var calveWithData: UIView!
    @IBOutlet var calveLabelView: UIView!
    @IBOutlet var calveLabel: UILabel!
    
    
    @IBOutlet var wiegthLabel: UILabel!
    @IBOutlet var weigthWithData: UIView!
    @IBOutlet var weigthLabelView: UIView!
    
    
    @IBOutlet var neckWithData: UIView!
    @IBOutlet var neckLabel: UILabel!
    @IBOutlet var neckLabelView: UIView!
    
    
    @IBOutlet var waistLabel: UILabel!
    @IBOutlet var waistWithData: UIView!
    @IBOutlet var waistLabelView: UIView!
    
    
    @IBOutlet var hipLabel: UILabel!
    @IBOutlet var hipLabelView: UIView!
    @IBOutlet var hipWithData: UIView!
    
    @objc func openReports(_ sender: UITapGestureRecognizer? = nil) {
        chestWithData.isHidden = !chestWithData.isHidden
        chestLabel.isHidden = !chestLabel.isHidden
        if !chestWithData.isHidden {
            chest.becomeFirstResponder()
        }
    }
    
    @objc func openReports2(_ sender: UITapGestureRecognizer? = nil) {
        calveWithData.isHidden = !calveWithData.isHidden
        calveLabel.isHidden = !calveLabel.isHidden
        if !calveWithData.isHidden {
            calve.becomeFirstResponder()
        }
    }
    
    @objc func openReports3(_ sender: UITapGestureRecognizer? = nil) {
        weigthWithData.isHidden = !weigthWithData.isHidden
        wiegthLabel.isHidden = !wiegthLabel.isHidden
        if !weigthWithData.isHidden {
            weight.becomeFirstResponder()
        }
    }
    
    @objc func openReports4(_ sender: UITapGestureRecognizer? = nil) {
        neckWithData.isHidden = !neckWithData.isHidden
        neckLabel.isHidden = !neckLabel.isHidden
        
        if !neckWithData.isHidden {
            neck.becomeFirstResponder()
        }
    }
    
    @IBOutlet weak var saveButton: UIButton!
    @objc func openReports5(_ sender: UITapGestureRecognizer? = nil) {
        waistWithData.isHidden = !waistWithData.isHidden
        waistLabel.isHidden = !waistLabel.isHidden
        
        if !waistLabel.isHidden {
            waist.becomeFirstResponder()
        }
    }
    
    @objc func openReports6(_ sender: UITapGestureRecognizer? = nil) {
        hipWithData.isHidden = !hipWithData.isHidden
        hipLabel.isHidden = !hipLabel.isHidden
        
        if !hipWithData.isHidden {
            hip.becomeFirstResponder()
        }
    }
    
    func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(openReports(_:)))
        chestLabelView.addGestureRecognizer(tap)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(openReports2(_:)))
        calveLabelView.addGestureRecognizer(tap2)
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(openReports3(_:)))
        weigthLabelView.addGestureRecognizer(tap3)
        
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(openReports4(_:)))
        neckLabelView.addGestureRecognizer(tap4)
        
        let tap5 = UITapGestureRecognizer(target: self, action: #selector(openReports5(_:)))
        waistLabelView.addGestureRecognizer(tap5)
        
        let tap6 = UITapGestureRecognizer(target: self, action: #selector(openReports6(_:)))
        hipLabelView.addGestureRecognizer(tap6)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        
    }
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

extension MeasurementsAdditionViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if neck.hasText && waist.hasText && weight.hasText {
            saveButton.isEnabled = true
            saveButton.setTitleColor(.green, for: .normal)
        }
        else {
            saveButton.isEnabled = false
            saveButton.setTitleColor(.gray, for: .normal)
        }
    }
}
