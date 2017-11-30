//
//  MessageService.swift
//  Smack
//
//  Created by Sadman Sakib Saumik on 11/28/17.
//  Copyright © 2017 Sadman Sakib Saumik. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService{
    static let instance = MessageService()
    
    var channels = [Channel]()
    var messages = [Message]()
    
    var selectedChannel:Channel?
    
    
    func findAllChannels(completion: @escaping CompletionHandler){
        Alamofire.request(URL_GET_ALL_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {return}
                let json = JSON(data).array!
                for item in json {
                    let channel = Channel(id: item["_id"].stringValue, name: item["name"].stringValue, description: item["description"].stringValue)
                    self.channels.append(channel)
                    print(channel)
                }
                
                /*
                 //Doing Things with Decodable Protocol
                 do{
                    self.channels = try JSONDecoder().decode([Channel].self, from: data)
                } catch let error {
                    debugPrint(error as Any)
                }
                print(self.channels)
                */
                
                completion(true)
            }else{
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    func findMessagesbyChannelID(completion: @escaping CompletionHandler){
        guard let ChannelID = self.selectedChannel?.id else {return}
        Alamofire.request("\(URL_GET_MESSAGES)\(ChannelID)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                self.clearMessages()
                guard let data = response.data else {return}
                guard let messages = JSON(data).array else {return}
                //var message: Message
                for item in messages {
                    let messageBody = item["messageBody"].stringValue
                    let userId = item["userId"].stringValue
                    let channelId = item["channelId"].stringValue
                    let userName = item["userName"].stringValue
                    let userAvatar = item["userAvatar"].stringValue
                    let userAvatarColor = item["userAvatarColor"].stringValue
                    let id = item["_id"].stringValue
                    let timeStamp = item["timeStamp"].stringValue
                    let message = Message(messageBody: messageBody, userId: userId, channelId: channelId, userName: userName, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                    print(message)
                    self.messages.append(message)
                }
                completion(true)
            }else{
                debugPrint(response.result.error as Any)
                completion(false)
            }
            
        }
    }
    
    
    func clearChannel(){
        self.channels.removeAll()
        NotificationCenter.default.post(name: NOTIF_CHANNELS_DATA_CHANGED, object: nil)
    }
    func clearMessages(){
        self.messages.removeAll()
       // NotificationCenter.default.post(name: NOTIF_CHANNELS_DATA_CHANGED, object: nil)
    }
    func selectedChannelInfo(id:String, name:String, description:String) {
        selectedChannel = Channel(id: id, name: name, description: description)
    }
}
