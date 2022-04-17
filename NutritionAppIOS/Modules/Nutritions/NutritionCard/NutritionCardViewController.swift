//
//  NutritionCardViewController.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 16.04.2021.
//

import UIKit
import Cosmos

class NutritionCardViewController: UIViewController, NutritionCardViewControllerProtocol {
    var presenter: NutritionCardPresenterProtocol!
    let configurator: NutritionCardConfiguratorProtocol = NutritionCardConfigurator()
    var inOnSelection: Bool = true
    var nutritionInfo: SingleNutritionist!
    
    @IBOutlet weak var stars: CosmosView!
    func setupAboutField(with text: String) {
        infoLabel.text = text
    }
    func setupIsAlreadyBooked(with condition: Bool) {
        bookNutritionistButton.isEnabled = !condition
    }
    var id: String!
    func dataSetup() {
        
        if nutritionInfo!.male {
            setNewImage(linkToPhoto: "\(urlToImage)\(nutritionInfo.avatarUrl ?? "")",imageInput:backImage, isRounded: false)
        }
        else {
            setNewImage(linkToPhoto: "\(urlToImage)\(nutritionInfo.avatarUrl ?? "")",imageInput:backImage, isRounded: false)
        }
        if !inOnSelection {
            bookNutritionistButton.isEnabled = false
            bookNutritionistButton.setTitle("Выбран", for: .normal)
        }
        id = "\(nutritionInfo.id)"
        stars.rating = nutritionInfo.rating
        nameLabel.text = nutritionInfo.name
        emailLabel.text = nutritionInfo.email
        infoLabel.text = nutritionInfo.about
        birthdayLabel.text = nutritionInfo.birthDate
        rateLabel.text = "\(nutritionInfo.rating)"
        priceLabel.text = "\(nutritionInfo.monthPrice)"

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    func setupGestures() {
        presenter.setupGestures()
    }
    @IBOutlet weak var bookNutritionistButton: UIButton!
    
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var startsLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBAction func bookNutritionist(_ sender: Any) {
        presenter.bookNewNurtionist()
    }
}
