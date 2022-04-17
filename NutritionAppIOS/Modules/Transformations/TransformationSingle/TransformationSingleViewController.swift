//
//  TransformationSingleViewController.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 24.04.2021.
//

import UIKit

class TransformationSingleViewController: UIViewController {

    @IBOutlet weak var textForReport: UILabel!
    @IBOutlet weak var photoOfTransformation: UIImageView!
    
    var textForReportString = ""
    var linkToPhoto: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestures()
        textForReport.text = textForReportString
        setNewImage(linkToPhoto: "\(urlToImage)\(linkToPhoto ?? "")", imageInput: photoOfTransformation, isRounded: false)
        
    }
    
    func setupGestures() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleDismissGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @objc func handleDismissGesture(gesture: UISwipeGestureRecognizer) -> Void {
        self.dismiss(animated: true, completion: nil)
    }
}
