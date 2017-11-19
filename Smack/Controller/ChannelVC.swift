//
//  ViewController.swift
//  Smack
//
//  Created by Sadman Sakib Saumik on 11/19/17.
//  Copyright © 2017 Sadman Sakib Saumik. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    @IBAction func prepareForSegue(segue: UIStoryboardSegue){}
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
    }

    @IBAction func LoginTapped(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: self)
    }
}
