//
//  ParticularChatTableViewCell.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 06.05.2021.
//

import UIKit
import Kingfisher

class ParticularChatTableViewCell: UITableViewCell {
    let colorForMyMessages = UIColor(displayP3Red: 55/255, green: 63/255, blue: 67/255, alpha: 1)
    
    let colorForFriendMessages = UIColor(displayP3Red: 84/255, green: 88/255, blue: 89/255, alpha: 1)

    @IBOutlet weak var heightDataLabel: NSLayoutConstraint!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var messageText: UILabel!
    @IBOutlet weak var dateOfMessage: UILabel!
    
    @IBOutlet weak var messageBubble: UIView!
    
    
    func setIsReaded(date dateGiven: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        let dateDate = (dateFormatter.date(from: dateGiven) ?? Date()).convert(from: TimeZone(abbreviation: "UTC")!, to: TimeZone.current)
        dateFormatter.dateFormat = "HH:mm"
        
        let image1Attachment = NSTextAttachment()
        let imageOffsetY: CGFloat = 0.0
        let fullString = NSMutableAttributedString(string: dateFormatter.string(from: dateDate))

        
        image1Attachment.image = UIImage(named: "read")!.resize(maxWidthHeight: 13)
        image1Attachment.bounds = CGRect(x: 0, y: imageOffsetY, width: image1Attachment.image!.size.width, height: image1Attachment.image!.size.height)
        let image1String = NSAttributedString(attachment: image1Attachment)
        fullString.append(image1String)
        timeLabel.attributedText = fullString
        
        dateFormatter.dateFormat = "dd LLLL yyyy"
        dateOfMessage.text = dateFormatter.string(from: dateDate)
    }
    func getHoursFromDate(date dateGiven: String) {
        
        DispatchQueue.global(qos: .utility).async {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
            let dateDate = (dateFormatter.date(from: dateGiven) ?? Date()).convert(from: TimeZone(abbreviation: "UTC")!, to: TimeZone.current)
            dateFormatter.dateFormat = "HH:mm"
            DispatchQueue.main.async {
                self.timeLabel.text = dateFormatter.string(from: dateDate)
                dateFormatter.dateFormat = "dd LLLL yyyy"
                self.dateOfMessage.text = dateFormatter.string(from: dateDate)
            }
        }


    }
    var message: SingleMessageModel! {
        didSet {
            if message.isNewDate! {
                dateOfMessage.isHidden = false
                heightDataLabel.constant = 16.5
            }
            else {
                dateOfMessage.isHidden = true
                heightDataLabel.constant = 0
            }
            if !message.incoming && message.read {
                setIsReaded(date: message.sendDate)
            }
            else {
                getHoursFromDate(date: message.sendDate)
            }
            setNewImage(linkToPhoto: message.avatarUrl, imageInput: avatar, placeholderPic: "male_mock_avatar")

            if message.messageType == "TEXT" {
                messageText.attributedText = nil
                messageText.text = message.text
            }
            else if message.messageType == "REPORT" {
                setupReporImage()
            }


            if message.incoming {
                messageBubble.backgroundColor = colorForFriendMessages
                avatar.isHidden = false
                }
            else {
                messageBubble.backgroundColor = colorForMyMessages
                avatar.isHidden = true
            }
            
        }
        
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func setupReporImage() {
        let image1Attachment = NSTextAttachment()
        let imageOffsetY: CGFloat = 0.0
        var fullString = NSMutableAttributedString(string: "")
    
        image1Attachment.image = UIImage(named: "foodPlaceholder")?.resize(maxWidthHeight: 150)
        image1Attachment.bounds = CGRect(x: 0, y: imageOffsetY, width: image1Attachment.image!.size.width, height: image1Attachment.image!.size.height)
        let image1String = NSAttributedString(attachment: image1Attachment)
        fullString.append(image1String)
        self.messageText.attributedText = fullString
                    
    KingfisherManager.shared.cache.retrieveImage(forKey: "\(urlToImage)\(self.message.text)", options: nil) { (result) in
        switch result {
        case .success(let value):
            if let safeImage = value.image {
            image1Attachment.image = safeImage.resize(maxWidthHeight: 150)
            image1Attachment.bounds = CGRect(x: 0, y: imageOffsetY, width: image1Attachment.image!.size.width, height: image1Attachment.image!.size.height)
            let image1String = NSAttributedString(attachment: image1Attachment)
                fullString = NSMutableAttributedString(string: "")
                fullString.append(image1String)
                DispatchQueue.main.async {
                    if self.message.messageType == "REPORT" {
                        self.messageText.attributedText = fullString
                    }
                    else {
                        self.messageText.text = self.message.text
                    }
                }
            }

            break
        case .failure(let _):
            DispatchQueue.global(qos: .background).async {
                let url = URL(string: "\(urlToImage)\(self.message.text)")
                if let safeData = try? Data(contentsOf: url!) {
                    image1Attachment.image = UIImage(data: safeData)?.resize(maxWidthHeight: 150)
                    image1Attachment.bounds = CGRect(x: 0, y: imageOffsetY, width: image1Attachment.image!.size.width, height: image1Attachment.image!.size.height)
                    let image1String = NSAttributedString(attachment: image1Attachment)
                    fullString = NSMutableAttributedString(string: "")
                    fullString.append(image1String)
                    DispatchQueue.main.async {
                        if self.message.messageType == "REPORT" {
                            
                            self.messageText.attributedText = fullString
                        }
                        else {
                            self.messageText.text = self.message.text
                        }
                    }
                }
                else {
                }
            }
            break
        }
    }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension Date {
    func convert(from initTimeZone: TimeZone, to targetTimeZone: TimeZone) -> Date {
        let delta = TimeInterval(initTimeZone.secondsFromGMT() + targetTimeZone.secondsFromGMT())
        return addingTimeInterval(delta)
    }
}
