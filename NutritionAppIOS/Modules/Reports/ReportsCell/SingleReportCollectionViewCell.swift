//
//  SingleReportCollectionViewCell.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 13.04.2021.
//

import UIKit

class SingleReportCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photoOfFood: UIImageView!
    weak var parent: UIViewController!
    var reportComment: String!
    var link:String?{
        didSet{
            setNewImage(linkToPhoto: "\(urlToImage)\(link ?? "")", imageInput: photoOfFood, isRounded: false, placeholderPic: "foodPlaceholder")
            let tap2 = UITapGestureRecognizer(target: self, action: #selector(openSingleReport(_:)))
            photoOfFood.addGestureRecognizer(tap2)

        }
    }
    @objc func openSingleReport(_ sender: UITapGestureRecognizer? = nil) {
         let nextController = parent.storyboard?.instantiateViewController(withIdentifier: "ReportsViewerViewController") as! ReportsViewerViewController
        nextController.textForReport = reportComment
        nextController.linkToImage = link!
        parent.present(nextController, animated: true, completion: nil)
    }
}
