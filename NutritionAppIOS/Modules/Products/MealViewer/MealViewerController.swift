//
//  MealViewerController.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 14.06.2021.
//

import UIKit


class MealViewerController: UIViewController {

    @IBOutlet weak var openReportsView: UIImageView!
    @IBOutlet weak var mealBackView: UIView!
    @IBOutlet weak var closeView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var topMealLabel: UILabel!
    @IBOutlet weak var addNewMealButton: UIImageView!
    @IBOutlet weak var productsListTableView: UITableView!
    
    var typeOfMeal: MealType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @objc func openReports(_ sender: UITapGestureRecognizer? = nil) {
        let cl = (self.storyboard?.instantiateViewController(withIdentifier: "reportsAdditionViewController") as! ReportsAdditionViewController)
        self.present(cl, animated: true, completion: nil)
    }
    
    @objc func openAdditionScreen(_ sender: UITapGestureRecognizer? = nil) {
        let mealAdditionController = "MealAdditionController"
        let nextController = self.storyboard?.instantiateViewController(withIdentifier: mealAdditionController) as! MealAdditionController
        nextController.typeOfMeal = typeOfMeal
        self.present(nextController, animated: true, completion: nil)
    }
    
    func setupView() {
        setupGestures()
        setupViewByMealType()
        productsListTableView.delegate = self
        productsListTableView.dataSource = self
    }
    func setupViewByMealType() {
        topMealLabel.text = typeOfMeal.rawValue
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = mealBackView!.bounds
        gradientLayer.cornerRadius = 23
        var colors = [CGColor]()
        
        switch typeOfMeal {
        case .breakfast:
            colors = [CGColor(red: 250/255, green: 217/255, blue: 97/255, alpha: 1), CGColor(red: 247/255, green: 107/255, blue: 28/255, alpha: 1)]
            addNewMealButton.image = UIImage(named: "buttonOrange")
            break
        case .dinner:
            colors = [CGColor(red: 245/255, green: 81/255, blue: 95/255, alpha: 1), CGColor(red: 169/255, green: 7/255, blue: 47/255, alpha: 1)]
            addNewMealButton.image = UIImage(named: "buttonRed")
            break
        case .snack:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
            colors = [CGColor(red: 68/255, green: 197/255, blue: 229/255, alpha: 1),CGColor(red: 167/255, green: 255/255, blue: 171/255, alpha: 1)]
            addNewMealButton.image = UIImage(named: "buttonGreen")
            break
        case .lunch:
            colors = [CGColor(red: 92/255, green: 95/255, blue: 232/255, alpha: 1), CGColor(red: 101/255, green: 104/255, blue: 236/255, alpha: 1), CGColor(red: 149/255, green: 157/255, blue: 255/255, alpha: 1)]
            addNewMealButton.image = UIImage(named: "buttonBlue")
            break
        default:
            break
        }
        gradientLayer.colors = colors
        mealBackView!.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupGestures() {
        let tapReport = UITapGestureRecognizer(target: self, action: #selector(openReports(_:)))
        openReportsView.addGestureRecognizer(tapReport)
        
        let addFood = UITapGestureRecognizer(target: self, action: #selector(openAdditionScreen(_:)))
        addNewMealButton.addGestureRecognizer(addFood)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        let closeWindowGesture = UITapGestureRecognizer(target: self, action: #selector(closeCurrentWindow(_:)))
        closeView.addGestureRecognizer(closeWindowGesture)
    }
    
    
    @objc func closeCurrentWindow(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension MealViewerController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MealTableViewCell! = ((tableView.dequeueReusableCell(withIdentifier: "MealTableViewCell")) as! MealTableViewCell)
        return cell
    }
    
    
}
