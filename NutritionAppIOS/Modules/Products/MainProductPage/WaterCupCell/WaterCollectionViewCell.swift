//
//  WaterCollectionViewCell.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 08.06.2021.
//

import UIKit

class WaterCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cupImage: UIImageView!
    var isDrinked: Bool!
    
    var setup:Bool! {
        didSet {
            if isDrinked {
                cupImage.image = UIImage(named: "waterCup")
            }
            else {
                cupImage.image = UIImage(named: "waterCupNotDrink")
            }
        }
    }
}
