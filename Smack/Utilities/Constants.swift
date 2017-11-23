//
//  File.swift
//  Smack
//
//  Created by Sadman Sakib Saumik on 11/19/17.
//  Copyright © 2017 Sadman Sakib Saumik. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success:Bool)->()

//Urls
//let LOCAL_URL = "http://localhost:3005/v1/"
let BASE_URL = "https://ssmack.herokuapp.com/v1/"
let URL_REGISTER = BASE_URL+"account/register"
let URL_LOGIN = "\(BASE_URL)account/login"

//Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannelVC"

//User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

//Headers
let HEADER = [ "Content-Type" : "application/json; charset=UTF-8" ]
