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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1.0]"
    var bgColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        userNameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [.foregroundColor : smackPurplePlaceholder])
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
        emailTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
        spinner.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
        
    }
    @objc func handleTap(){
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            avatarName = UserDataService.instance.avatarName
            profileImage.image = UIImage(named: UserDataService.instance.avatarName)
            if avatarName.contains("light") && bgColor == nil {
                self.profileImage.backgroundColor = UIColor.lightGray
            }
        }
    }
    @IBAction func closeButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    @IBAction func avaterPickerTapped(_ sender: Any) {
        performSegue(withIdentifier: AVATAR_PICKER, sender: nil)
    }
    
    @IBAction func createAccountTapped(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
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
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                                print("User Added Successfully!")
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                            }
                        })
                        
                    }
                }
            }
        }
        
    }
    
    @IBAction func generateBackgroundColorTapped(_ sender: Any) {
        let r = CGFloat(arc4random_uniform(255))/255
        let g = CGFloat(arc4random_uniform(255))/255
        let b = CGFloat(arc4random_uniform(255))/255
        avatarColor = "[\(r), \(g), \(b), 1.0]"
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1.0)
        UIView.animate(withDuration: 0.2) {
                self.profileImage.backgroundColor = self.bgColor
        }
        print(avatarColor)
    }
    
}
