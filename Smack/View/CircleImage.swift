//
//  CircleImage.swift
//  Smack
//
//  Created by Sadman Sakib Saumik on 11/26/17.
//  Copyright © 2017 Sadman Sakib Saumik. All rights reserved.
//

import UIKit

class CircleImage: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = self.frame.size.width/2
        clipsToBounds = true
    }
}
