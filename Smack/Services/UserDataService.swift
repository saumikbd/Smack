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
    func setAvatarName(avatarName: String){
        self.avatarName = avatarName
    }
    
    func getAvatarColor(components: String)-> UIColor {
        let scanner = Scanner(string: components)
        let skipped = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
       
        var r, g, b, a: NSString?
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        guard let rUnwrapped = r?.doubleValue else{
            return UIColor.lightGray
        }
        guard let gUnwrapped = g?.doubleValue else{
            return UIColor.lightGray
        }
        guard let bUnwrapped = b?.doubleValue else{
            return UIColor.lightGray
        }
        guard let aUnwrapped = a?.doubleValue else{
            return UIColor.lightGray
        }
        let rFloat = CGFloat(rUnwrapped)
        let gFloat = CGFloat(gUnwrapped)
        let bFloat = CGFloat(bUnwrapped)
        let aFloat = CGFloat(aUnwrapped)
        
        
        return UIColor(red: rFloat, green: gFloat, blue: bFloat, alpha: aFloat)
    }
}
