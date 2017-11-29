//
//  ViewController.swift
//  Smack
//
//  Created by Sadman Sakib Saumik on 11/19/17.
//  Copyright © 2017 Sadman Sakib Saumik. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBAction func prepareForSegue(segue: UIStoryboardSegue){}
    
    @IBOutlet weak var userImage: CircleImage!
    @IBOutlet weak var loginButon: UIButton!
    @IBOutlet weak var channelTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.channelTable.rowHeight = 30
        revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(channelDataDidChange(_:)), name: NOTIF_CHANNELS_DATA_CHANGED, object: nil)
        
        channelTable.delegate = self
        channelTable.dataSource = self
        SocketService.instance.getChannel { (success) in
            if success {
                self.channelTable.reloadData()
            }
        }
        if AuthService.instance.isLoggedIn {
            MessageService.instance.findAllChannels(completion: { (success) in
                if success {
                    self.channelTable.reloadData()
                }
            })
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupUserInfo()
    }
    @objc func channelDataDidChange(_ notif: Notification){
        channelTable.reloadData()
    }
    
    @objc func userDataDidChange(_ notif: Notification){
        setupUserInfo()
    }
    func setupUserInfo(){
        if AuthService.instance.isLoggedIn {
            loginButon.setTitle(UserDataService.instance.name, for: UIControlState.normal)
            userImage.image = UIImage(named: UserDataService.instance.avatarName)
            userImage.backgroundColor = UserDataService.instance.getAvatarColor(components: UserDataService.instance.avatarColor)
        }else{
            loginButon.setTitle("Login", for: .normal)
            userImage.image = UIImage(named: "menuProfileIcon")
            userImage.backgroundColor = UIColor.clear
        }
    }
    
    @IBAction func LoginTapped(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            let profileVC = ProfileVC()
            profileVC.modalPresentationStyle = .custom
            present(profileVC, animated: true, completion: nil)
        }
        else {
            performSegue(withIdentifier: TO_LOGIN, sender: self)
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell {
                cell.setupView(channel: MessageService.instance.channels[indexPath.row])
                return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = MessageService.instance.channels[indexPath.row]
        MessageService.instance.selectedChannel = channel
        NotificationCenter.default.post(name: NOTIF_CHANNEL_SELECTED, object: nil)
        print("Channel #\(channel.name) Selected")
    }
    
    
    @IBAction func addChannelTapped(_ sender: Any) {
        if AuthService.instance.isLoggedIn{
            let addChannelVC = AddChannelVC()
            addChannelVC.modalPresentationStyle = .custom
            present(addChannelVC, animated: true, completion: nil)
        }
    }
    
    
}
