//
//  WaterAlertViewController.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 08.06.2021.
//

import UIKit


class WaterAlertViewController: UIViewController {
    @IBOutlet weak var labelWithData: UILabel!
    @IBOutlet weak var waterSlider: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(named: "thumbWaterImage")
        labelWithData.text = "\(selectedWater)"
        waterSlider.value = Float(selectedWater)
        waterSlider.setThumbImage(image, for: .normal)
        waterSlider.setThumbImage(image, for: .highlighted)
    }
    var selectedWater = UserDefaults.standard.integer(forKey: "WaterBalanceSelected")
    @IBAction func moveWaterSlider(_ sender: UISlider) {
        var someValue = sender.value/200.0
        someValue.round()
        someValue = someValue*200
        selectedWater = Int(someValue)
        labelWithData.text = "\(selectedWater)"
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        UserDefaults.standard.setValue(selectedWater, forKey: "WaterBalanceSelected")
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
}
