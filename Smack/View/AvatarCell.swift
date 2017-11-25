//
//  AvatarCell.swift
//  Smack
//
//  Created by Sadman Sakib Saumik on 11/25/17.
//  Copyright © 2017 Sadman Sakib Saumik. All rights reserved.
//

import UIKit

enum AvatarType{
    case dark
    case light
}
class AvatarCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    func updateView(index:Int, avatarType: AvatarType) {
        switch avatarType {
        case .dark:
            layer.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
            avatarImage.image = UIImage(named: "dark\(index)")
        case .light:
            layer.backgroundColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
            avatarImage.image = UIImage(named: "light\(index)")
        }
    }
}
