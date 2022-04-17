//
//  MealAdditionController.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 14.06.2021.
//

import UIKit

enum MealType: String {
    case breakfast = "Завтрак"
    case dinner = "Ужин"
    case lunch = "Обед"
    case snack = "Перекус"
}
protocol MealAdditionControllerProtocol {
   func setupView()
}
class MealAdditionController: UIViewController {

    @IBOutlet weak var counterImage: UILabel!
    @IBOutlet weak var removeAllSection: UIButton!
    @IBAction func removeSelectionFunction() {
        
    }
    func setupCounterImageLabel(with number: Int) {
        DispatchQueue.main.async {
            self.counterImage.text = "Выбрано (\(number))"
        }
    }
    var selectedProducts = [String]()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var topMealLabel: UILabel!
    var typeOfMeal: MealType!
    @IBOutlet weak var closeView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupViewByMealType()
        setupSearch()
    }
    
    func setupSearch() {
        searchBar.becomeFirstResponder()
        searchBar.delegate = self
        (UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])).clearButtonMode = .never
        searchBar.tintColor = .white
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.leftView?.tintColor = .white
        }
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .white
        searchBar.isTranslucent = false
    }
    func setupViewByMealType() {
        topMealLabel.text = typeOfMeal.rawValue
        
        switch typeOfMeal {
        case .breakfast:
            break
        default:
            break
        }
    }
    func setupView() {
        setupGestures()
        hideKeyboardWhenTappedAround()
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupGestures() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        let closeWindowGesture = UITapGestureRecognizer(target: self, action: #selector(closeCurrentWindow(_:)))
        closeView.addGestureRecognizer(closeWindowGesture)
    }
    
    
    @objc func closeCurrentWindow(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true, completion: nil)
    }
    func searchRequest(_ searchText: String) {
        ApiService.shared.searchRequest(with: searchText) {
            data, err in
            print(data)
        }
    }
}

extension MealAdditionController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            searchRequest(searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.becomeFirstResponder()
    }
}

extension MealAdditionController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        selectedProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
    
    
}
