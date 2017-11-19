//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Sadman Sakib Saumik on 11/19/17.
//  Copyright © 2017 Sadman Sakib Saumik. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func closeButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
}
