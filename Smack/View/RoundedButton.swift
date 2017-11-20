//
//  RoundedButton.swift
//  Smack
//
//  Created by Sadman Sakib Saumik on 11/21/17.
//  Copyright © 2017 Sadman Sakib Saumik. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    @IBInspectable var cornerRadius:CGFloat = 10 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        setRadius()
    }
    func setRadius(){
        layer.cornerRadius = cornerRadius
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setRadius()
    }

}
