//
//  AddChannelVC.swift
//  Smack
//
//  Created by Sadman Sakib Saumik on 11/28/17.
//  Copyright © 2017 Sadman Sakib Saumik. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    
    @IBOutlet weak var channelName: UITextField!
    @IBOutlet weak var channelDescription: UITextField!
    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeTap(_:)))
        backgroundView.addGestureRecognizer(tap)
        
        channelName.attributedPlaceholder = NSAttributedString(string: "channel name", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
        channelDescription.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedStringKey.foregroundColor : smackPurplePlaceholder])
        
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var createChannelTapped: RoundedButton!
    

}
