//
//  ViewController.swift
//  Smack
//
//  Created by Sadman Sakib Saumik on 11/19/17.
//  Copyright © 2017 Sadman Sakib Saumik. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageTxt: UITextField!
    @IBOutlet weak var chatTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.bindToKeyboard()
        chatTable.dataSource = self
        chatTable.delegate = self
        
        //chatTable.rowHeight = 140
        chatTable.estimatedRowHeight = 140
        chatTable.rowHeight = UITableViewAutomaticDimension
        
        menuBtn.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        revealViewController().tapGestureRecognizer()
        revealViewController().panGestureRecognizer()
        NotificationCenter.default.addObserver(self, selector: #selector(selectedChannel(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail(completion: { (success) in
                if(success){
                    NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                    MessageService.instance.findAllChannels(completion: { (success) in
                        if success {
                            NotificationCenter.default.post(name: NOTIF_CHANNELS_DATA_CHANGED, object: nil)
                            self.onLoginMessages()
                        }
                    })
                }
            })
            
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
        
    }
    @objc func handleTap(){
        view.endEditing(true)
    }
    
    @objc func selectedChannel(_ notif : Notification){
        chatTable.reloadData()
        updateView()
        revealViewController().revealToggle(animated: true)
    }
    func updateView(){
        guard let channel = MessageService.instance.selectedChannel else{return}
        titleLabel.text = "#\(channel.name)"
        MessageService.instance.findMessagesbyChannelID { (success) in
            if success {
                print("Success fetching messages");
                self.chatTable.reloadData()
            }
        }
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            
            guard let message = messageTxt.text , messageTxt.text != "" else {return}
            print(message)
            SocketService.instance.addmessage(messageBody: message, completion: { (success) in
                if success {
                    self.messageTxt.text = ""
                    print("message added")
                }
            })
        }
    }
    
    func onLoginMessages(){
        if MessageService.instance.channels.count > 0 {
            MessageService.instance.selectedChannel = MessageService.instance.channels[0]
            updateView()
        } else {
            titleLabel.text = "No Channels Yet!"
        }
        self.reloadInputViews()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as? ChatCell {
            cell.updateView(message: MessageService.instance.messages[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    

}
