//
//  Channel.swift
//  Smack
//
//  Created by Sadman Sakib Saumik on 11/28/17.
//  Copyright © 2017 Sadman Sakib Saumik. All rights reserved.
//

import Foundation

struct Channel {
    private(set) var id:String
    private(set) var name:String
    private(set) var description:String
}

/*
//With Decodable Protocol
struct Channel: Decodable {
    private(set) var _id:String
    private(set) var name:String
    private(set) var description: String
    private(set) var __v:Int
}
*/
