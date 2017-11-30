//
//  SocketService.swift
//  Smack
//
//  Created by Sadman Sakib Saumik on 11/29/17.
//  Copyright © 2017 Sadman Sakib Saumik. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    
    static let instance = SocketService()
    let manager:SocketManager
    let socket: SocketIOClient
    
    override init() {
        manager = SocketManager(socketURL: URL(string: BASE_URL)!)
        socket = manager.defaultSocket
        super.init()
    }
    func establishConnection(){
        socket.connect()
    }
    func closeConnection(){
        socket.disconnect()
    }
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler){
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler){
        socket.on("channelCreated") { (data, ack) in
            guard let name = data[0] as? String else {return}
            guard let description = data[1] as? String else {return}
            guard let id = data[1] as? String else {return}
            let newChannel = Channel(id: id, name: name, description: description)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    func addmessage(messageBody: String, completion: @escaping CompletionHandler){
        let messageBody = messageBody
        let userId = UserDataService.instance.id
        guard let channelId = MessageService.instance.selectedChannel?.id else {return}
        let userName = UserDataService.instance.name
        let userAvatar = UserDataService.instance.avatarName
        let userAvatarColor = UserDataService.instance.avatarColor
        socket.emit("newMessage", messageBody, userId, channelId, userName, userAvatar, userAvatarColor)
        completion(true)
    }
    
    
}
