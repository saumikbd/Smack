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
    
    @IBOutlet weak var userImage: CircleImage!
    @IBOutlet weak var loginButon: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(userDataDidChange), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
    }
    @objc func userDataDidChange(){
            //print("Things Will be done")
        loginButon.setTitle(UserDataService.instance.name, for: UIControlState.normal)
        userImage.image = UIImage(named: UserDataService.instance.avatarName)
        userImage.backgroundColor = UserDataService.instance.getAvatarColor(components: UserDataService.instance.avatarColor)
    }
    
    @IBAction func LoginTapped(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: self)
    }
}
