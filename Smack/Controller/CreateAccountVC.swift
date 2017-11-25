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
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1.0]"
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            avatarName = UserDataService.instance.avatarName
            profileImage.image = UIImage(named: UserDataService.instance.avatarName)
        }
    }
    @IBAction func closeButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    @IBAction func avaterPickerTapped(_ sender: Any) {
        performSegue(withIdentifier: AVATAR_PICKER, sender: nil)
    }
    
    @IBAction func createAccountTapped(_ sender: Any) {
        guard let email:String = emailTxt.text, emailTxt.text != "" else{
            return
        }
        guard let password:String = passwordTxt.text ,  passwordTxt.text != "" else{
            return
        }
        guard let username:String = userNameTxt.text, userNameTxt.text != "" else {
            return
        }
        
       AuthService.instance.registerUser(email: email, password: password) { (success) in
            if success {
                print("registered successfully!")
                AuthService.instance.loginUser(email: email, password: password) { (success) in
                    if success {
                        print("User Logged in!\n Authtoken: ", AuthService.instance.authToken)
                        AuthService.instance.createUser(name: username, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success {
                                print("User Added Successfully!")
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                            }
                        })
                        
                    }
                }
            }
        }
        
    }
}
