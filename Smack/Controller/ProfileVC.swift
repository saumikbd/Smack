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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(exitTap(_:)))
        backgroundView.addGestureRecognizer(tap)
    }
    
    @objc func exitTap(_ tap: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
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
        AuthService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    

}
