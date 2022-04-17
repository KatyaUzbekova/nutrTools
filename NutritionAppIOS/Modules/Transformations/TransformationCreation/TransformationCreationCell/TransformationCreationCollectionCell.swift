//
//  TransformationCreationCollectionCell.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 05.06.2021.
//

import UIKit

class TransformationCreationCollectionCell: UICollectionViewCell {
    @IBOutlet weak var photoOfTransformation: UIImageView!
    @IBOutlet weak var closeButton: UIImageView!
    @IBOutlet weak var pickerImage: UIImageView!
    
    var index: Int!
    weak var parent: TransformationCreationViewController!
    
    var image: UIImage?{
        didSet {
            if let safeImage = image {
                closeButton.isHidden = false
                photoOfTransformation.image = safeImage
                pickerImage.isHidden = true
            }
            else {
                closeButton.isHidden = true
                photoOfTransformation.image = nil
                pickerImage.isHidden = false
            }
            
            let tap2 = UITapGestureRecognizer(target: self, action: #selector(deleteImage(_:)))
            closeButton.addGestureRecognizer(tap2)
        }
    }
    
    func deleteImage() {
        parent.pickedImages.remove(at: index)
        if parent.pickedImages.count == 0 {
            parent.presenter.openCameraToSelectPhotos()
        }
    }
    
    @objc func deleteImage(_ sender: UITapGestureRecognizer? = nil) {
        photoOfTransformation.image = nil
        closeButton.isHidden = true
        pickerImage.isHidden = false
        deleteImage()
    }

}
