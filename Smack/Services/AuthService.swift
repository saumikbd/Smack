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
               /* if let json = response.result.value as? Dictionary<String, Any> {
                    if let email = json["user"] as? String {
                        self.userEmail = email
                    }
                    if let token = json["token"] as? String {
                        self.authToken = token
                    }
                }*/
                guard let data = response.data else { return }
                do {
                let json = try JSON(data: data)
                self.userEmail = json["user"].stringValue
                self.authToken = json["token"].stringValue

                self.isLoggedIn = true
                completion(true)
                } catch {
                    
                }
            }
            else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
}
