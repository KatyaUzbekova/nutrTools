//
//  ReportsViewerViewController.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 09.04.2021.
//

import UIKit

class ReportsViewerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNewImage(linkToPhoto: "\(urlToImage)\(linkToImage)", imageInput: imageViewBackground)
        menu.text = textForReport
        setupGestures()
    }
    
    @IBAction func closeView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var textForReport = String()
    var linkToImage = String()
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupGestures() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @IBOutlet weak var imageViewBackground: UIImageView!
    
    @IBOutlet weak var menu: UILabel!
}
