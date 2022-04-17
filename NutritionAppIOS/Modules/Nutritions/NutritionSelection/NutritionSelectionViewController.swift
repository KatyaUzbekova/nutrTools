//
//  NutritionSelectionViewController.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 16.04.2021.
//

import UIKit

class NutritionSelectionViewController: UIViewController, NutritionSelectionViewControllerProtocol {
    var presenter: NutritionsSelectionPresenterProtocol!
    let configurator: NutritionsSelectionConfiguratorProtocol = NutritionsSelectionConfigurator()
    
    var allNutritionists = [SingleNutritionist]()
    func reloadData() {
        DispatchQueue.main.async {
            self.nutritionsTableView.reloadData()
        }
    }
    func tableDataSetup(with data: [SingleNutritionist]) {
        allNutritionists = data
        print("hello")
        reloadData()
    }
    func setupGradienLayer(with layer: CAGradientLayer) {
        gradientView!.layer.mask = layer
    }
    
    func tableViewPreSetup() {
        nutritionsTableView.delegate = self
        nutritionsTableView.dataSource = self
        registerTableViewCells()
    }
    @IBOutlet weak var gradientView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    func setupGestures() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleDismissGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    @objc func handleDismissGesture(gesture: UISwipeGestureRecognizer) -> Void {
        presenter.closeCurrentWindow()
    }
    @IBAction func backButtonAction(_ sender: Any) {
        presenter.closeCurrentWindow()
    }
    @IBOutlet weak var nutritionsTableView: UITableView!
    
    private func registerTableViewCells() {
        let cell = UINib(nibName: "NutritionistTableViewCell",
                         bundle: nil)
        self.nutritionsTableView.register(cell,
                                          forCellReuseIdentifier: "NutritionistTableViewCell")
    }
}


// MARK: TableView Delegate and DataSource
extension NutritionSelectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allNutritionists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NutritionistTableViewCell") as? NutritionistTableViewCell {
            cell.isOnSelection = true
            cell.nutritionistsData = allNutritionists[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func openCard(with index: Int) {
        let nextController = (self.storyboard?.instantiateViewController(withIdentifier: "NutritionCardViewController") as! NutritionCardViewController)
        nextController.nutritionInfo = allNutritionists[index]
        self.present(nextController, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openCard(with: indexPath.row)
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        openCard(with: indexPath.row)
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
