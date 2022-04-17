//
//  ReportsViewController.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 08.04.2021.
//

import UIKit

protocol ReportsViewControllerProtocol: class {
    func setHiddenLabel(with boolValue: Bool)
    func setupGestures()
    func setupGradientView()
    func setupBackgroundPhoto(with image:UIImage)
    var allReports: [ReportsModel]! {set get}
    func reloadTableView()
    
}

class ReportsViewController: UIViewController, ReportsViewControllerProtocol {
    private var allReportsArray = [ReportsModel]()
    func reloadTableView() {
        DispatchQueue.main.async {
            self.reportsTable.reloadData()
        }
    }
    
    var allReports: [ReportsModel]! {
        set {
            allReportsArray = newValue
            reportsTable.reloadData()
        }
        get {
            allReportsArray
        }
    }
    @objc func loadList(notification: NSNotification) {
        presenter.reloadTableView()
    }
    var presenter: ReportsPresenterProtocol!
    let configurator: ReportsConfiguratorProtocol = ReportsConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    func setHiddenLabel(with boolValue: Bool) {
        reportsTable.isHidden = boolValue
        emptyListLabel.isHidden = !boolValue
    }
    @IBOutlet var backgroundPhoto: UIImageView!
    
    func setupBackgroundPhoto(with image:UIImage) {
        backgroundPhoto.image = image
    }
    
    func setupGradientView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.gradientView!.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, CGColor(red: 35/255, green: 39/255, blue: 39/255, alpha: 1)]
        
        gradientView!.layer.mask = gradientLayer
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadList(notification:)), name: NSNotification.Name(rawValue: "reloadReports"), object: nil)
    }
    
    @IBOutlet weak var gradientView: UIView!
    @IBAction func createNewReport(_ sender: Any) {
        presenter.createNewReportsClicked()
    }
    func setupGestures() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        reportsTable.delegate = self
        reportsTable.dataSource = self
    }
    @IBOutlet weak var emptyListLabel: UILabel!
    
    @IBOutlet weak var reportsTable: UITableView!
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        presenter.closeButtonClicked()
    }
    
    @IBAction func returnBackAction(_ sender: Any) {
        presenter.closeButtonClicked()
    }
}



extension ReportsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allReports.count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ReportsTableViewCell! = (tableView.dequeueReusableCell(withIdentifier: "reportsListCellId") as! ReportsTableViewCell)
        if indexPath.row < allReports.count {
            cell.dateOfReport.text = allReports[indexPath.row].reportDate
            cell.reports = allReports[indexPath.row].reports
            cell.parent = self
        }
        else {
            let cell = UITableViewCell()
            cell.selectionStyle = .none
            cell.heightAnchor.constraint(equalToConstant: 60).isActive = true
            cell.backgroundColor = .clear
            return cell
        }
        return cell
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
