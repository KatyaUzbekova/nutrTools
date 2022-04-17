//
//  SingleTransformationCollectionViewCell.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 30.05.2021.
//

import UIKit

class SingleTransformationCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photoOfTransformation: UIImageView!
    weak var parent: UIViewController!
    var reportComment: String!
    var link:String?{
        didSet{
            setNewImage(linkToPhoto: "\(urlToImage)\(link ?? "")", imageInput: photoOfTransformation, isRounded: false, placeholderPic: "foodPlaceholder")
            let tap2 = UITapGestureRecognizer(target: self, action: #selector(openSingleReport(_:)))
            photoOfTransformation.addGestureRecognizer(tap2)
        }
    }
    @objc func openSingleReport(_ sender: UITapGestureRecognizer? = nil) {
         let nextController = parent.storyboard?.instantiateViewController(withIdentifier: "TransformationSingleViewController") as! TransformationSingleViewController
        nextController.textForReportString = reportComment.removingPercentEncoding!
        nextController.linkToPhoto = link
        parent.present(nextController, animated: true, completion: nil)
    }
}
