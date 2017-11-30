//
//  TableViewCell.swift
//  Smack
//
//  Created by Sadman Sakib Saumik on 11/30/17.
//  Copyright © 2017 Sadman Sakib Saumik. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var profileImage: CircleImage!
    @IBOutlet weak var messageTxt: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateView(message: Message){
        profileImage.image = UIImage(named: message.userAvatar)
        profileImage.backgroundColor = UserDataService.instance.getAvatarColor(components: message.userAvatarColor)
        timeStamp.text = message.timeStamp
        messageTxt.text = message.messageBody
        userName.text = message.userName
    }
    

}
