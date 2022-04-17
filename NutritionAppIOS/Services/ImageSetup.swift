//
//  ImageSetup.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 06.04.2021.
//

import Foundation
import Kingfisher

func setNewImage(linkToPhoto: String?, imageInput: UIImageView, isRounded: Bool = false, placeholderPic: String = "placeholderPic.png") {
    
    let url = URL(string: linkToPhoto ?? "")
    DispatchQueue.main.async {
        let processor = DownsamplingImageProcessor(size: imageInput.bounds.size)
        imageInput.kf.indicatorType = .activity
        imageInput.kf.setImage(
            with: url,
            placeholder: UIImage(named: placeholderPic),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ], completionHandler:
                {
                    result in
//                    switch result {
//                    case .success(let value):
//                      //  print("Task done for: \(value.source.url?.absoluteString ?? "")")
//                    case .failure(let error):
//                      //  print("Job failed: \(error.localizedDescription)")
//                    }
                })
        if isRounded {
            imageInput.setRounded()
        }
    }
}

extension UIImageView{
    func setRounded() {
        
        //self.layer.borderWidth = 1
        self.layer.masksToBounds = false
       // self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
}
