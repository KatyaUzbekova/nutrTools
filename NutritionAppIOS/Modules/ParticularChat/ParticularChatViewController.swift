//
//  ParticularChatViewController.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 03.05.2021.
//

import UIKit

protocol ParticularChatViewControllerProtocol: class {
    func setupView()
}


class ParticularChatViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var sectedPhotosCollectionView: UICollectionView!
    @IBOutlet weak var chatStoryTableView: UITableView!
    @IBOutlet weak var constraintBottom: NSLayoutConstraint!
    @IBOutlet weak var heightOfSelectedPhotosView: NSLayoutConstraint!
    @IBOutlet weak var photoAdditionButton: NSLayoutConstraint!
    @IBOutlet weak var sendMessageButton: UIButton!
    
    var messagesArray = [SingleMessageModel]()
    var selectedPhotos = [String]()
    
    func selectedViewIsExist(){
        var constant = 0
        if selectedPhotos.count == 0 {
            constant = 0
        }
        else {
            constant = 100
        }
        DispatchQueue.main.async {
            self.heightOfSelectedPhotosView.constant = CGFloat(constant)
        }
    }
    var chatId: CLong!
    var nutritionistId: String!
    
    func reloadTableView() {
         DispatchQueue.main.async {
            self.chatStoryTableView.reloadData()
            self.chatStoryTableView.scrollToRow(at: IndexPath.init(row: self.firstUnreaded - 1, section: 0), at: .bottom, animated: false)
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.invalidateSocketConnection()
    }
    var firstUnreaded = 0
    func getChatHistory() {
        ApiService.shared.getParticularChatHistory(chatId: "\(chatId!)", nutritionistId: nutritionistId) {data,error in
            if let safeData = data {
                self.messagesArray = data!.array
                if safeData.firstUnreaded == -1 {
                    self.firstUnreaded = safeData.array.count
                }
                else {
                    self.firstUnreaded = safeData.firstUnreaded
                }
                self.reloadTableView()
                

            }
            
            print("\(data)")
        }
    }
    
    let configurator: ParticularChatConfiguratorProtocol = ParticularChatConfigurator()
    var presenter: ParticularChatPresenterProtocol!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        presenter.configureView(for: chatId)

        
        DispatchQueue.global(qos: .background).async {
            self.getChatHistory()
        }
        selectedViewIsExist()
        setupGestures()
    }
    var showKeyboard = false
    
    var keyBoardSizeSave = CGFloat(0.0)
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        if showKeyboard == false || keyBoardSizeSave != keyboardSize.height {
            showKeyboard = true
            keyBoardSizeSave = keyboardSize.height
            constraintBottom.constant = keyboardSize.height
        }
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        guard ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil else {
            return
        }
        if showKeyboard {
            showKeyboard = false
            constraintBottom.constant = 0
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.count > 0 {
            
        }
    }
    @IBOutlet weak var closeView: UIView!
    @IBAction func sendMessageAction(_ sender: Any) {
        let sendedText = textFieldChat.text!
        if FDMStompManager.shared.socket!.isConnected() {
            presenter.sendMessage(text: sendedText)
            
            if messagesArray.count > 0 {
                let referencedTime = messagesArray[messagesArray.count - 1].lastDate!
                let nowDate = Date()
                if referencedTime.fullDistance(from: nowDate, resultIn: .day)! > 0 {
                    messagesArray.append(SingleMessageModel(name: "user", avatarUrl: nil, messageId: 1, chatId: 1, senderId: 1, messageType: "TEXT", text: sendedText, sendDate: "", read: false, incoming: false, isNewDate: true, lastDate: nowDate))
                }
                else {
                    messagesArray.append(SingleMessageModel(name: "user", avatarUrl: nil, messageId: 1, chatId: 1, senderId: 1, messageType: "TEXT", text: sendedText, sendDate: "", read: false, incoming: false, isNewDate: false, lastDate: referencedTime))
                }
            }
            reloadTableView()
            DispatchQueue.main.async {
            }
            
            textFieldChat.text = ""
            textFieldChat.becomeFirstResponder()
            
            textFieldChat.constraints.forEach {(constraint) in
                if constraint.firstAttribute == .height {
                    constraint.constant = 35
                }
            }
            sendMessageButton.isEnabled = false
            sendMessageButton.tintColor = UIColor(displayP3Red: 119/255, green: 119/255, blue: 119/255, alpha: 1)
        }
        else {
            self.showToast(message: "Проблемы с соединением, попробуйте еще раз", seconds: 0.5)
        }

    }
    @IBAction func photoAdditionAction(_ sender: Any) {
    }

    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: textFieldChat.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        if textView.text.replacingOccurrences(of: "\\s", with: "", options: .regularExpression) == "" {
            sendMessageButton.isEnabled = false
            sendMessageButton.tintColor = UIColor(displayP3Red: 119/255, green: 119/255, blue: 119/255, alpha: 1)
        }
        else {
            sendMessageButton.isEnabled = true
            sendMessageButton.tintColor = UIColor(displayP3Red: 126/255, green: 211/255, blue: 33/255, alpha: 1)
        }
        textFieldChat.constraints.forEach {(constraint) in
            if constraint.firstAttribute == .height {
                if estimatedSize.height + 5 < 150 {
                    constraint.constant = estimatedSize.height + 5
                }
            }
        }
    }
    
    func setupView() {
        name.text = nameData
        chatStoryTableView.delegate = self
        chatStoryTableView.dataSource = self
        
        sectedPhotosCollectionView.delegate = self
        sectedPhotosCollectionView.dataSource = self
        
        textFieldChat.delegate = self
        textFieldChat.becomeFirstResponder()
        hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(ParticularChatViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ParticularChatViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBOutlet weak var textFieldChat: UITextView!
    @IBOutlet weak var name: UILabel!
    var nameData = ""
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
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        self.dismiss(animated: true, completion: nil)
    }
}


//MARK: tableViewDelegate && tableViewDataSource
extension ParticularChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ParticularChatTableViewCell! = ((tableView.dequeueReusableCell(withIdentifier: "ParticularChatTableViewCell")) as! ParticularChatTableViewCell)
        cell.message = messagesArray[indexPath.row]
        if cell.message.incoming && !cell.message.read {
            presenter.sendMessageRead(with: cell.message.messageId)
        }
        return cell
    }
}


//MARK: collectionViewDelegate && collectionViewDataSource
extension ParticularChatViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}


//MARK: VIPER EXTENSION FROM PRESENTER
extension ParticularChatViewController: ParticularChatViewControllerProtocol {
    
}

