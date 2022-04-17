//
//  NutritionistTableViewCell.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 16.04.2021.
//

import UIKit
import Cosmos

class NutritionistTableViewCell: UITableViewCell {
    @IBOutlet weak var starsCountingLabel: CosmosView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var birthDate: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var ratingsLabel: UILabel!
    @IBOutlet var button: UIButton!
    @IBOutlet var labelWithDate: UILabel!
    @IBOutlet var chat: UIImageView!
    var isOnSelection = false
    var id = "1"
    
    @IBAction func followingParticularNutritionist(_ sender: Any) {
        ApiService.shared.postBookNewNutritionistJson(with: id, completion: {data,_ in
        })
    }
    var nutritionistsData: SingleNutritionist! {
        didSet {
            priceLabel.text = "\(nutritionistsData.monthPrice)"
            
            if isOnSelection {
                button.setTitle("Выбрать", for: .normal)
            }
            else {
                button.setTitle("Написать", for: .normal)
            }
            ratingsLabel.text = "\(nutritionistsData.rating)"
            labelWithDate.text = "Был(а): \(nutritionistsData.lastOnline)"
            if nutritionistsData!.male {
                setNewImage(linkToPhoto: "\(urlToImage)\(nutritionistsData.avatarUrl ?? "")",imageInput:avatar, isRounded: true, placeholderPic: "male_mock_avatar")
            }
            else {
                setNewImage(linkToPhoto: "\(urlToImage)\(nutritionistsData.avatarUrl ?? "")",imageInput:avatar, isRounded: true, placeholderPic: "female_mock_avatar")
            }
            starsCountingLabel.rating = nutritionistsData.rating
            name.text = nutritionistsData.name
            email.text = nutritionistsData.email
            birthDate.text = nutritionistsData.birthDate
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
