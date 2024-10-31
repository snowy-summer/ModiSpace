//
//  ChannelChatListDTO.swift
//  ModiSpace
//
//  Created by 전준영 on 10/31/24.
//

import Foundation

struct ChannelChatListDTO: Decodable {
    
    let channelID: String
    let channelName: String
    let chatID: String
    let content: String
    let createdAt: String
    let files: [String]
    let user: OtherUserDTO
    
    enum CodingKeys: String, CodingKey {
        case channelID = "channel_id"
        case channelName
        case chatID = "chat_id"
        case content
        case createdAt
        case files
        case user
    }
    
}
