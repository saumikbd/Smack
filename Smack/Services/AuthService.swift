//
//  AuthService.swift
//  Smack
//
//  Created by Sadman Sakib Saumik on 11/20/17.
//  Copyright © 2017 Sadman Sakib Saumik. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService{
    static let instance = AuthService()
    let defaults = UserDefaults.standard
    
    var isLoggedIn:Bool{
        get{
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set{
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    var authToken:String{
        get{
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set{
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    var userEmail:String{
        get{
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set{
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    
    //USER REGISTER
    func registerUser(email:String, password:String, completion: @escaping CompletionHandler){
        
        let lowerCasedEmail = email.lowercased()
        let body = [
            "email" : lowerCasedEmail,
            "password" :password
        ]
        
        //testing
        print("\n\n"+URL_LOGIN+"\n")
        print(body["email"]!+"\n"+body["password"]!+"\n")
        print("\n"+HEADER["Content-Type"]!+"\n")
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            
            //testing
            print("\n")
            print(response)
            print("\n")

            if response.result.error == nil {
                completion(true)
            }
            else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
    
    //USER LOGIN
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler){
        let lowerCasedEmail = email.lowercased()
        
        let body = [
            "email" : lowerCasedEmail ,
            "password" : password
        ]
        //testing
        print("\n\n"+URL_LOGIN+"\n")
        print(body["email"]!+"\n"+body["password"]!+"\n")
        print("\n"+HEADER["Content-Type"]!+"\n")
        
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil {
                print(response)
                /*if let json = response.result.value as? Dictionary<String, Any> {
                    if let email = json["user"] as? String {
                        self.userEmail = email
                    }
                    if let token = json["token"] as? String {
                        self.authToken = token
                    }
                }*/
                
                guard let data = response.data else { return }
                let json = JSON(data)
                self.userEmail = json["user"].stringValue
                self.authToken = json["token"].stringValue
                self.isLoggedIn = true
                completion(true)
            }
            else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
    //CREATE USER
    func createUser(name:String, email:String, avatarName:String, avatarColor:String, completion: @escaping CompletionHandler){
        let lowerCasedEmail = email.lowercased()
        let body = [
            "name": name,
            "email": lowerCasedEmail,
            "avatarName": avatarName,
            "avatarColor" : avatarColor
        ]
        Alamofire.request(URL_ADDUSER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {return}
                self.setUserInfo(data: data)
                completion(true)
                
            }
            else{
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
        
        
    }
    
    func findUserByEmail(completion: @escaping CompletionHandler) {
        print("\(URL_USER_BY_EMAIL)\(userEmail)")
        Alamofire.request("\(URL_USER_BY_EMAIL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else{return}
                self.setUserInfo(data: data)
                completion(true)
                
            }else{
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
    func setUserInfo(data:Data) {
        let json = JSON(data)
        let id = json["_id"].stringValue
        let name = json["name"].stringValue
        let email = json["email"].stringValue
        let avatarName = json["avatarName"].stringValue
        let avatarColor = json["avatarColor"].stringValue
        
        UserDataService.instance.setUserInfo(id: id, name: name, email: email, avatarName: avatarName, avatarColor: avatarColor)
    }
    
    //LOGOUT USER
    func logoutUser() {
        self.authToken = ""
        self.isLoggedIn = false
        self.userEmail = ""
        UserDataService.instance.setUserInfo(id: "", name: "", email: "", avatarName: "", avatarColor: "")
    }
}
