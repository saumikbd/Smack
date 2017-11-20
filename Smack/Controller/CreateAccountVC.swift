//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Sadman Sakib Saumik on 11/19/17.
//  Copyright © 2017 Sadman Sakib Saumik. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func closeButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    @IBAction func createAccountTapped(_ sender: Any) {
        guard let email:String = emailTxt.text, emailTxt.text != "" else{
            return
        }
        guard let password:String = passwordTxt.text ,  passwordTxt.text != "" else{
            return
        }
        AuthService.instance.registerUser(email: email, password: password) { (success) in
            if success {
                print("registered successfully!")
            }
        }
    }
}
