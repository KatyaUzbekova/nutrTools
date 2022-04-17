//
//  MainProductPageViewController.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 08.06.2021.
//

import UIKit

protocol MainProductPageViewControllerProtocol: class {
    func setupView()
}


class MainProductPageViewController: UIViewController {
    
    
    // 4 view for a 4 times eatings
    @IBOutlet weak var breakfestFullView: UIView!
    @IBOutlet weak var snackFullView: UIView!
    @IBOutlet weak var dinnerFullView: UIView!
    @IBOutlet weak var lunchFullView: UIView!
    
    
    @objc func openViewController(_ sender: UITapGestureRecognizer? = nil) {
        let mealViewerControllerId = "MealViewerController"
        let nextController = self.storyboard?.instantiateViewController(withIdentifier: mealViewerControllerId) as! MealViewerController
        
        switch sender?.view {
        case breakfestFullView:
            nextController.typeOfMeal = .breakfast
            break
        case snackFullView:
            nextController.typeOfMeal = .snack
            break
        case dinnerFullView:
            nextController.typeOfMeal = .dinner
            break
        case lunchFullView:
            nextController.typeOfMeal = .lunch
            break
        default:
            break
        }

        self.present(nextController, animated: true, completion: nil)
    }
       
    func setupImageViews() {
        let imageViews = [breakfestFullView, lunchFullView, snackFullView, dinnerFullView]
        for imageView in imageViews {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openViewController(_:)))
            imageView!.addGestureRecognizer(tapGestureRecognizer)
        }
    }

    
    @IBOutlet weak var proteinsProgressView: UIProgressView!
    @IBOutlet weak var carbohydratesProgressView: UIProgressView!
    @IBOutlet weak var fatsProgressView: UIProgressView!
    

    
    
    
    private var volumeOfSingleCup = 200
    var volumeSetup = 5200
    var drinkedVolume = 0
    
    @IBOutlet weak var drinkedWaterLabel: UILabel!
    @IBOutlet weak var setupWaterLabel: UILabel!
    @IBOutlet weak var drankedWaterInSliderView: UIProgressView!
    var numberOfWaterCups = 26
    var lastCheckedWater = 0
    @IBOutlet weak var heightOfWater: NSLayoutConstraint!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var prevDateLabel: UIImageView!
    @IBOutlet weak var nextDayLabel: UIImageView!
    
    @IBOutlet weak var openWaterAlertController: UIImageView!
    @IBOutlet weak var waterCollectionView: UICollectionView!
    
    func setupGestures() {
        openWaterPickerController()
    }
    func openWaterPickerController(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(openWaterController(_:)))
        self.openWaterAlertController.addGestureRecognizer(tap)
    }
    @objc func openWaterController(_ sender: UITapGestureRecognizer? = nil) {
        setupAlert()
    }
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = UserDefaults.standard.value(forKey: "WaterBalanceSelected") {
            volumeSetup = UserDefaults.standard.value(forKey: "WaterBalanceSelected") as! Int
        }
        setupWaterLabel.text = "\(volumeSetup) мл "
        numberOfWaterCups = volumeSetup/volumeOfSingleCup
        setupView()
    }
    
    func postDrinkedWater() {
        let parameters = WaterParameters(date: "11-06-2021 23:51", mills: drinkedVolume)
        ApiService.shared.postWater(parameters: parameters) {
            _,_ in
        }
    }
    func getData() {
        ApiService.shared.getWater() { [self]
            data, err in
            if err == nil && data == nil {
                lastCheckedWater = 0
            }
            else if let safeData = data {
                drinkedVolume = safeData.mills
                drankedWaterInSliderView.progress = Float(drinkedVolume)/Float(volumeSetup)
                lastCheckedWater = drinkedVolume/volumeOfSingleCup
                drinkedWaterLabel.text = "\(drinkedVolume) мл/ "
                var valueOfDivision = Double(numberOfWaterCups)/8.0
                valueOfDivision.round(.up)
                heightOfWater.constant = CGFloat(36.0*valueOfDivision + 10.0*(valueOfDivision-1))
                DispatchQueue.main.async {
                    waterCollectionView.reloadData()
                }
            }
        }
    }
    
    func setupAlert() {
        let storyboard = UIStoryboard(name: "WaterAlert", bundle: nil)
        let myAlert = (storyboard.instantiateViewController(withIdentifier: "alert") as! WaterAlertViewController)
        myAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        myAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(myAlert, animated: true, completion: nil)
    }

    
    @IBAction func openAdditionScreen(_ sender: UIButton) {
        let mealAdditionController = "MealAdditionController"
        let nextController = self.storyboard?.instantiateViewController(withIdentifier: mealAdditionController) as! MealAdditionController
        switch sender.restorationIdentifier {
        case "breakfastAddButton":
            nextController.typeOfMeal = .breakfast
            break
        case "lunchAddButton":
            nextController.typeOfMeal = .lunch
            break
        case "dinnerAddButton":
            nextController.typeOfMeal = .dinner
            break
        case "snackAddButton":
            nextController.typeOfMeal = .snack
            break
        default:
            break
        }

        
        self.present(nextController, animated: true, completion: nil)
    }
    
    
    func setupView() {
        waterCollectionView.delegate = self
        waterCollectionView.dataSource = self
        setupGestures()
        setupImageViews()
        getData()
    }
}

extension MainProductPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numberOfWaterCups
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainProductPageCell", for: indexPath) as! WaterCollectionViewCell

        if (indexPath.row+1) * (indexPath.section+1)-1 < lastCheckedWater {
            cell.isDrinked = true
        }
        else {
            cell.isDrinked = false
        }
        cell.setup = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        lastCheckedWater = (indexPath.row+1) * (indexPath.section+1)
        drinkedVolume = volumeOfSingleCup*lastCheckedWater

        postDrinkedWater()
        DispatchQueue.main.async { [self] in
            drankedWaterInSliderView.progress = Float(drinkedVolume)/Float(volumeSetup)
            drinkedWaterLabel.text = "\(drinkedVolume) мл/ "
            self.waterCollectionView.reloadData()
        }
    }
}


extension UIView {
    class func loadFromNib<T: UIView>(with nibName: String) -> T {
        return Bundle.main.loadNibNamed(nibName, owner: self, options: nil)![0] as! T
    }
}


