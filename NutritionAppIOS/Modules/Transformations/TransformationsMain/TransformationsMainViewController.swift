//
//  TransformationsMainViewController.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 24.04.2021.
//

import UIKit

class TransformationsMainViewController: UIViewController, TransformationsMainViewControllerProtocol {

    private var allTransformArray = [SingleTransformation]()
    var allTransformations: [SingleTransformation]! {
        set {
            allTransformArray = newValue
            transformationsTableView.reloadData()
        }
        get {
            allTransformArray
        }
    }
    @objc func loadList(notification: NSNotification) {
        DispatchQueue.main.async {
            self.transformationsTableView.reloadData()
        }
    }
    @IBOutlet weak var setHiddenLabel: UILabel!
    @IBOutlet weak var closeView: UIView!
    @IBOutlet weak var gradientView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ApiService.shared.getAllTransformationsJson() {
            data,error in
            if data != nil {
                if data?.array.count == 0 {
                    self.setHiddenLabel.isHidden = false
                    self.transformationsTableView.isHidden = true
                }
                else {
                    self.setHiddenLabel.isHidden = true
                    self.transformationsTableView.isHidden = false
                }
                self.allTransformations = data!.array
            }
        }
        setupGradientView()
        setupGestures()
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadList(notification:)), name: NSNotification.Name(rawValue: "reloadTransformations"), object: nil)

        transformationsTableView.delegate = self
        transformationsTableView.dataSource = self
    }
    
    @IBAction func addNewTransformation(_ sender: Any) {
        let cl = (self.storyboard?.instantiateViewController(withIdentifier: "TransformationCreationViewController") as! TransformationCreationViewController)
        self.present(cl, animated: true, completion: nil)
    }
    func setupGestures() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleDismissGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    @objc func handleDismissGesture(gesture: UISwipeGestureRecognizer) -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var transformationsTableView: UITableView!
    func setupGradientView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.gradientView!.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, CGColor(red: 35/255, green: 39/255, blue: 39/255, alpha: 1)]
        
        gradientView!.layer.mask = gradientLayer
    }
}


extension TransformationsMainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allTransformArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : TransformationEntity! = (tableView.dequeueReusableCell(withIdentifier: "TransformationEntity") as! TransformationEntity)

        cell.dateOfSubmission.text = allTransformArray[indexPath.row].date
        cell.transformations = allTransformArray[indexPath.row].imageListURL
        cell.parent = self
        cell.comments = allTransformArray[indexPath.row].comment
        return cell
    }
    
    
}
