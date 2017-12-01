//
//  LoginVC.swift
//  Smack
//
//  Created by Sadman Sakib Saumik on 11/19/17.
//  Copyright © 2017 Sadman Sakib Saumik. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tap)
    }
    
    
    //SETTING UP VIEW
    
    func setupView(){
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
        emailTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
        spinner.isHidden = true
    }
    
    //GESTURE RECOGNIZERS
    
    @objc func handleTap(_ recognizer: UIGestureRecognizer){
        view.endEditing(true)
    }
    
    
    //IBACTIONS
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func createAccoutTapped(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    @IBAction func loginTapped(_ sender: Any) {
        print("login  tapped!")
        guard let email = emailTxt.text, emailTxt.text != "" else {return}
        guard let password = passwordTxt.text, passwordTxt.text != "" else {return}
        
        self.spinner.isHidden = false
        self.spinner.startAnimating()
        
        AuthService.instance.loginUser(email: email, password: password) { (success) in
            if success {
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success {
                        MessageService.instance.findAllChannels { (success) in
                            if success {
                                NotificationCenter.default.post(name: NOTIF_CHANNELS_DATA_CHANGED, object: nil)
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                                self.dismiss(animated: true, completion: nil)
                            }
                        }
                    }
                })
            }
        }
    }
    
}
