//
//  ChannelCell.swift
//  Smack
//
//  Created by Sadman Sakib Saumik on 11/28/17.
//  Copyright © 2017 Sadman Sakib Saumik. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {
    
    @IBOutlet weak var channelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        }else{
            layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    func setupView(channel: Channel){
        let title = channel.name
        self.channelName.text = "#\(title)"
    }

}
