//
//  UserDataService.swift
//  Smack
//
//  Created by Sadman Sakib Saumik on 11/24/17.
//  Copyright © 2017 Sadman Sakib Saumik. All rights reserved.
//

import Foundation
class UserDataService{
    
    static let instance = UserDataService()
    
    private(set) var id = ""
    private(set) var name = ""
    private(set) var email = ""
    private(set) var avatarName = ""
    private(set) var avatarColor = ""
    
    func setUserInfo(id: String, name:String, email:String, avatarName:String, avatarColor:String){
        self.id = id
        self.name = name
        self.email = email
        self.avatarName = avatarName
        self.avatarColor = avatarColor
    }
}
