//
//  ChannelChatListDTO.swift
//  ModiSpace
//
//  Created by 전준영 on 10/31/24.
//

import Foundation

struct ChannelChatListDTO: Decodable, Identifiable, Equatable {
    
    var id = UUID()
    let channelID: String
    let channelName: String
    let chatID: String
    let content: String?
    let createdAt: String
    let files: [String]
    let user: OtherUserDTO
    let isCurrentUser: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case channelID = "channel_id"
        case chatID = "chat_id"
        case channelName, content, createdAt, files, user, isCurrentUser
    }
    
}

