//
//  LineGradients.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 10.06.2021.
//


public enum GradientOrientation {
    case vertical
    case horizontal
}

import UIKit

extension UIImage {

    public convenience init?(bounds: CGRect, colors: [UIColor], orientation: GradientOrientation = .horizontal) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map({ $0.cgColor })
        
        if orientation == .horizontal {
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0);
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0);
        }

        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}

import UIKit

class GradientProgressView: UIProgressView {
    
    @IBInspectable var firstColor: UIColor = UIColor.white {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var secondColor: UIColor = UIColor.black {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
                
        if let gradientImage = UIImage(bounds: self.bounds, colors: [firstColor, secondColor]) {
            self.progressImage = gradientImage
        }
    }
}
