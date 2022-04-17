//
//  TransformationCreationViewController.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 24.04.2021.
//

import UIKit

class TransformationCreationViewController: UIViewController, TransformationCreationViewControllerProtocol {

    func setupPlaceholderText() {
        commentsTextView.text = "Комментарий к фото..."
        commentsTextView.textColor = .lightGray
        commentsTextView.delegate = self
    }
    
    @IBOutlet weak var imagesForTransformation: UICollectionView!
    @IBOutlet weak var closeView: UIView!
    @IBOutlet weak var commentsTextView: UITextView!
    
    @IBOutlet weak var createTransformationButton: UIButton!
    var picker: ImagePicker!
    var pickedImages = [UIImage]()
    
    
    @IBAction func createTransformationAction(_ sender: UIButton) {
        if pickedImages.count > 0 {
            presenter.createNewTransformation(pickedImages, text: commentsTextView.text ?? "")
        }
    }
    
    var presenter: TransformationCreationPresenterProtocol!
    let configurator: TransformationCreationConfiguratorProtocol = TransformationCreationConfigurator()
    
    override func viewWillAppear(_ animated: Bool) {
        if pickedImages.count == 0 {
              presenter.openCameraToSelectPhotos()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    func initialSetup(borderWidth: CGFloat, borderColor: CGColor) {
        commentsTextView!.layer.borderWidth = borderWidth
        commentsTextView!.layer.borderColor = borderColor
        
        imagesForTransformation.delegate = self
        imagesForTransformation.dataSource = self
        self.hideKeyboardWhenTappedAround()
        
        setupPlaceholderText()
    }
    
    func setupGestures() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleDismissGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let closeViewGesture = UITapGestureRecognizer(target: self, action: #selector(closeViewGesture(_:)))
        self.closeView.addGestureRecognizer(closeViewGesture)
    }
    @objc func closeViewGesture(_ sender: UITapGestureRecognizer? = nil) {
        presenter.closeCurrentWindow()
    }
    @objc func handleDismissGesture(gesture: UISwipeGestureRecognizer) -> Void {
        presenter.closeCurrentWindow()
    }
}


extension TransformationCreationViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        if let safeImage = image {
            pickedImages.append(safeImage)
            DispatchQueue.main.async {
                self.imagesForTransformation.reloadData()
            }
        }
    }
}


extension TransformationCreationViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TransformationCreationCell", for: indexPath) as! TransformationCreationCollectionCell
        cell.parent = self
        cell.index = indexPath.row
        if pickedImages.count > indexPath.row {
            cell.image = pickedImages[indexPath.row]
        }
        else {
            cell.image = nil
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.openCameraToSelectPhotos()
    }
}

extension TransformationCreationViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = ""
            textView.textColor = .white
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Комментарий к фото..."
            textView.textColor = UIColor.lightGray
        }
    }
}
