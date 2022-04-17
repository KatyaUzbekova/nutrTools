//
//  ReportsAdditionViewController.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 09.04.2021.
//

import UIKit

protocol ReportsAdditionViewControllerProtocol: class {
    func setupGestures()
    var picker:ImagePicker! {set get}
    var pickedImage: UIImage? {set get}
    var insertedText: String? {set get}
    var view: UIView!  {set get}
    func setupImage(with image: UIImage)
    func initialSetup(borderWidth: CGFloat, borderColor: CGColor)
}

class ReportsAdditionViewController: UIViewController, ReportsAdditionViewControllerProtocol{
    
    func setupPlaceholderText() {
        commentsTextVIew.text = "Комментарий к отчету..."
        commentsTextVIew.textColor = .lightGray
        commentsTextVIew.delegate = self
    }
    
    var insertedText: String? {
        set {
            
        }
        get {
            return commentsTextVIew.text
        }
    }
    var pickedImage: UIImage? 
    
    var presenter: ReportsAdditionPresenterProtocol!
    let configurator: ReportsAdditionConfiguratorProtocol = ReportsAdditionConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    func setupImage(with image: UIImage) {
        pickImage.image = image
    }
    override func viewWillAppear(_ animated: Bool) {
        if pickedImage == nil {
            presenter.openCameraToSelectPhotos()
        }
    }
    
    func initialSetup(borderWidth: CGFloat, borderColor: CGColor) {
        commentsTextVIew!.layer.borderWidth = borderWidth
        commentsTextVIew!.layer.borderColor = borderColor
        self.hideKeyboardWhenTappedAround()
        setupPlaceholderText()
    }
    
    @IBAction func backButtonclicked(_ sender: Any) {
        presenter.closeButtonClicked()
    }
    func setupGestures() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.openNewPic(_:)))
        pickImage.addGestureRecognizer(tap)
    }
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var commentsTextVIew: UITextView!
    @IBOutlet weak var pickImage: UIImageView!
    @IBAction func createNewReport(_ sender: Any) {
        presenter.createNewReportsClicked()
    }
    var picker: ImagePicker!

    @objc func openNewPic(_ sender: UITapGestureRecognizer? = nil) {
        presenter.openCameraToSelectPhotos()
    }
    
}

extension ReportsAdditionViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        pickedImage = image
        presenter.setNewPhoto(image: image)
    }
}

extension ReportsAdditionViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = ""
            textView.textColor = .white
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Комментарий к отчету..."
            textView.textColor = UIColor.lightGray
        }
    }
}
