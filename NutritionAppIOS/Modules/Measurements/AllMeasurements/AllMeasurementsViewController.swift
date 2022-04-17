//
//  AllMeasurementsViewController.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 08.04.2021.
//

import Foundation
import UIKit

class AllMeasurementsViewController: UIViewController {
    @IBOutlet weak var tableViewReports: UITableView!

    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var emptyIndicatorLabel: UILabel!
    var allMeasurements = [SingleMeasurement]()
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableViewReports.reloadData()
        }
    }
    func setupGradientView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.gradientView!.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, CGColor(red: 35/255, green: 39/255, blue: 39/255, alpha: 1)]
        
        gradientView!.layer.mask = gradientLayer
    }
    
    @objc func loadList(notification: NSNotification) {
        getNewData()
    }
    func getNewData() {
        ApiService.shared.getAllMeasurementsJson{data,_ in
            if data != nil {
                if data!.array.count == 0 {
                    self.tableViewReports.isHidden = true
                    self.emptyIndicatorLabel.isHidden = false
                }
                else {
                    self.allMeasurements = data!.array
                    self.tableViewReports.isHidden = false
                    self.emptyIndicatorLabel.isHidden = true
                    self.reloadData()
                }
            }

        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradientView()
        tableViewReports.delegate = self
        tableViewReports.dataSource = self
        
        
        getNewData()
        NotificationCenter.default.addObserver(self, selector: #selector(loadList(notification:)), name: NSNotification.Name(rawValue: "reloadMeasurements"), object: nil)

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
    }
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func returnBackAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}


//MARK: TableView DataSource and Delegate
extension AllMeasurementsViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allMeasurements.count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < allMeasurements.count {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "reportsListId") as? MeasurementsTableViewCell {
                cell.reportsCellData = allMeasurements[indexPath.row]
                return cell
            }
        }
        else {
            let cell = UITableViewCell()
            cell.heightAnchor.constraint(equalToConstant: 60).isActive = true
            cell.backgroundColor = .clear
            return cell
        }
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.05 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
            })
    }
}
