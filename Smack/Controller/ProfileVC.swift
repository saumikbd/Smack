//
//  ProfileVC.swift
//  Smack
//
//  Created by Sadman Sakib Saumik on 11/27/17.
//  Copyright © 2017 Sadman Sakib Saumik. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var profileImage: CircleImage!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var userNameEditingTxt: UITextField!
    @IBOutlet weak var logoutUpdateButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var clearBg: UIView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        spinner.isHidden = true
        clearBg.isHidden = true
        userNameEditingTxt.isHidden = true
        userNameEditingTxt.text = UserDataService.instance.name
        let tapUserName = UITapGestureRecognizer(target: self, action: #selector(userNameLblTap(_:)))
        stackView.addGestureRecognizer(tapUserName)
        
        let tapClearBg = UITapGestureRecognizer(target: self, action: #selector(clearBgTap(_:)))
        clearBg.addGestureRecognizer(tapClearBg)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(exitTap(_:)))
        backgroundView.addGestureRecognizer(tap)
        view.bindToKeyboard()
        
    }
    
    @objc func exitTap(_ tap: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    @objc func userNameLblTap( _ tap: UITapGestureRecognizer){
        username.text = " "
        userNameEditingTxt.isHidden = false
        logoutUpdateButton.setTitle("Update", for: UIControlState.normal
        )
        clearBg.isHidden = false
    }
    @objc func clearBgTap (_ tap: UITapGestureRecognizer) {
        view.endEditing(true)
        userNameEditingTxt.isHidden = true
        username.text = UserDataService.instance.name
        logoutUpdateButton.setTitle("Logout", for: UIControlState.normal)
        clearBg.isHidden = true
    }
    
    func setupView() {
        profileImage.image = UIImage(named: UserDataService.instance.avatarName)
        profileImage.backgroundColor = UserDataService.instance.getAvatarColor(components: UserDataService.instance.avatarColor)
        username.text = UserDataService.instance.name
        email.text = UserDataService.instance.email
    }
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func logoutButtonTapped(_ sender: Any) {
        guard let buttonlbl = logoutUpdateButton.titleLabel?.text, logoutUpdateButton.titleLabel?.text != "" else {return}
        if buttonlbl == "Logout" {
            AuthService.instance.logoutUser()
            NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            dismiss(animated: true, completion: nil)
        }
        else if buttonlbl == "Update" {
            print("\n\n\nData Updated!\n\n\n")
            spinner.isHidden = false
            spinner.startAnimating()
            guard let name = userNameEditingTxt.text, userNameEditingTxt.text != "" else {return}
            AuthService.instance.updateUserName(name: name, completion: { (success) in
                if success {
                    print ("\(name)")
                    UserDataService.instance.setName(name: name)
                    self.username.text = name
                    self.username.isHidden = false
                    self.userNameEditingTxt.isHidden = true
                    self.view.endEditing(true)
                    self.spinner.isHidden = true
                    self.spinner.stopAnimating()
                    NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                }
            })
        }
    }
    

}
