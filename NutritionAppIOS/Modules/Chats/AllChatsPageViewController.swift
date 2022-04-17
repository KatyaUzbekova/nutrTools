//
//  AllChatsPageViewController.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 03.05.2021.
//

import UIKit


class AllChatsPageViewController: UIViewController, UITabBarControllerDelegate, AllChatsPageViewControllerProtocol {

    @IBOutlet var tableViewWithChats: UITableView!
    var allChats = [ChatListItemModel]()
    
    func setupAllChatLists() {
        ApiService.shared.getChatsListRequest() {
            data,error in
            if let safeData = data {
                self.allChats = []
                if safeData.array.count == 0 {
                    let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
                    alertController.title = NSLocalizedString("AllChatsPageViewController.Action.Nutrition", comment: "No nutritionist selection")
                    
                    alertController.addAction(UIAlertAction(title: NSLocalizedString("AllChatsPageViewController.Action.SelectNutrtion", comment: "select nutritionist"), style: .default) {_ in
                        let nutritionSelectionId = "FindYourNutritionVIew"
                        let nextController = self.storyboard?.instantiateViewController(withIdentifier: nutritionSelectionId) as! NutritionSelectionViewController
                        self.present(nextController, animated: true, completion: nil)
                    })
                    
                    alertController.addAction(UIAlertAction(title: NSLocalizedString("AllChatsPageViewController.Action.Return", comment: "Return from the screen"), style: .default) {_ in
                        self.tabBarController?.selectedIndex = 0
                    })

                    if UIDevice.current.userInterfaceIdiom == .pad {
                        alertController.popoverPresentationController?.sourceView = self.view
                        alertController.popoverPresentationController?.sourceRect = self.view.bounds
                        alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
                    }

                    self.present(alertController, animated: true)
                }
                self.allChats = safeData.array
                self.tableViewWithChats.reloadData()
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        setupAllChatLists()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewDelegates()
    }
    
    func setupViewDelegates() {
        tabBarController?.delegate = self
        tableViewWithChats.delegate = self
        tableViewWithChats.dataSource = self
    }

}

extension AllChatsPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allChats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ChatCellTableViewCell! = ((tableView.dequeueReusableCell(withIdentifier: "chatListCell")) as! ChatCellTableViewCell)
        cell.chatsList = allChats[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0

        UIView.animate(
            withDuration: 0.7,
            delay: 0.05 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
        })
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let nextController = self.storyboard?.instantiateViewController(withIdentifier: "ParticularChatViewController") as! ParticularChatViewController
        nextController.nameData = allChats[indexPath.row].nutritionistName
        nextController.chatId = allChats[indexPath.row].chatId
        nextController.nutritionistId = "\(allChats[indexPath.row].nutritionistId)"
        self.present(nextController, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextController = self.storyboard?.instantiateViewController(withIdentifier: "ParticularChatViewController") as! ParticularChatViewController
        nextController.nameData = allChats[indexPath.row].nutritionistName
        nextController.chatId = allChats[indexPath.row].chatId
        nextController.nutritionistId = "\(allChats[indexPath.row].nutritionistId)"
        self.present(nextController, animated: true, completion: nil)
    }
}
