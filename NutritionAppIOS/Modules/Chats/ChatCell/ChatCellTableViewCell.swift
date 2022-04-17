//
//  ChatCellTableViewCell.swift
//  NutritionAppIOS
//
//  Created by Екатерина Узбекова on 03.05.2021.
//

import UIKit

class ChatCellTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userfullname: UILabel!
    @IBOutlet weak var lastMessage: UILabel!
    @IBOutlet weak var viewCheckReaded: UIImageView!
    
    var chatsList: ChatListItemModel! {
        didSet {
            setNewImage(linkToPhoto: nil, imageInput: userImage, placeholderPic: "male_mock_avatar")
            userfullname.text = chatsList.nutritionistName
            lastMessage.text = chatsList.lastMessage
            if !chatsList.read && !chatsList.outgoing {
                viewCheckReaded.isHidden = false
            }
            else {
                viewCheckReaded.isHidden = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
