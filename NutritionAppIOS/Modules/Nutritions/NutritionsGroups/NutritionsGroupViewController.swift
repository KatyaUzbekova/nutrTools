//
//  NutritionsGroupViewController.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 16.04.2021.
//

import UIKit

class NutritionsGroupViewController: UIViewController {
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var activatedButton: UILabel!
    @IBOutlet weak var choosedButton: UILabel!
    @IBOutlet weak var waitingForActivationButton: UILabel!
    var tableData = [SingleNutritionist]()
    
    @objc func openActivated(_ sender: UITapGestureRecognizer? = nil) {
        activatedLine.isHidden = false
        waitingForActivationLine.isHidden = true
        choosedLine.isHidden = true
        tableData = activatedNutritionists
        self.reloadData()

    }
    
    @objc func openWaitingActivation(_ sender: UITapGestureRecognizer? = nil) {
        activatedLine.isHidden = true
        waitingForActivationLine.isHidden = false
        choosedLine.isHidden = true
        tableData = submittedNutritionists

        self.reloadData()

    }
    
    @objc func openChoosed(_ sender: UITapGestureRecognizer? = nil) {
        activatedLine.isHidden = true
        waitingForActivationLine.isHidden = true
        choosedLine.isHidden = false
        tableData = bookedNutritionists

        self.reloadData()

    }
    
    @IBAction func closeCurrentController(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    func setupGestures() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(openActivated(_:)))
        activatedButton.addGestureRecognizer(tap)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(openWaitingActivation(_:)))
        waitingForActivationButton.addGestureRecognizer(tap2)
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(openChoosed(_:)))
        choosedButton.addGestureRecognizer(tap3)
    }
    
    func reloadData() {
        if tableData.count == 0{
            DispatchQueue.main.async {
                self.nutritionsTableView.isHidden = true
                self.emptyLabel.isHidden = false
            }
            return
        }
        DispatchQueue.main.async {
            self.nutritionsTableView.isHidden = false
            self.emptyLabel.isHidden = true
            self.nutritionsTableView.reloadData()
        }
    }
    func setupGradientView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.gradientView!.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, CGColor(red: 35/255, green: 39/255, blue: 39/255, alpha: 1)]
        
        gradientView!.layer.mask = gradientLayer
    }
    
    @IBOutlet weak var activatedLine: UIImageView!
    @IBOutlet weak var waitingForActivationLine: UIImageView!
    @IBOutlet weak var choosedLine: UIImageView!
    
    
    var  activatedNutritionists =  [SingleNutritionist]()
    var submittedNutritionists =  [SingleNutritionist]()
    var bookedNutritionists =  [SingleNutritionist]()

    
    func apiRequest() {
        ApiService.shared.getAllMyNutritionsRequest() { [self]data,error in
            if data != nil {
                activatedNutritionists = data!.activatedNutritionists
                    submittedNutritionists =  data!.submittedNutritionists
                    bookedNutritionists = data!.bookedNutritionists
                }
            tableData = activatedNutritionists
            reloadData()
            }
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestures()
        nutritionsTableView.delegate = self
        nutritionsTableView.dataSource = self
        registerTableViewCells()
        setupGradientView()
        
        apiRequest()
    }

    @IBOutlet weak var nutritionsTableView: UITableView!
    
    @IBAction func backAction(_ sender: Any) {
    }
    
    @IBOutlet weak var emptyLabel: UILabel!
    private func registerTableViewCells() {
        let cell = UINib(nibName: "NutritionistTableViewCell",
                         bundle: nil)
        self.nutritionsTableView.register(cell,
                                          forCellReuseIdentifier: "NutritionistTableViewCell")
    }
}

extension NutritionsGroupViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NutritionistTableViewCell") as? NutritionistTableViewCell {
            cell.isOnSelection = false
            cell.id = "\(tableData[indexPath.row].id)"
            cell.nutritionistsData = tableData[indexPath.row]
            return cell
        }
        
        return UITableViewCell()
    }
    
    func openCard(with index: Int) {
        let nextController = (self.storyboard?.instantiateViewController(withIdentifier: "NutritionCardViewController") as! NutritionCardViewController)
        nextController.nutritionInfo = tableData[index]
        nextController.inOnSelection = false
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
