//
//  ChannelChatListDTO.swift
//  ModiSpace
//
//  Created by 전준영 on 10/31/24.
//

import Foundation

struct ChannelChatListDTO: Codable {
    
    let channelID: String
    let channelName: String
    let content: String
    let files: [String]
    
    init(
        channelID: String,
        channelName: String,
        content: String,
        files: [String] = []
    )
    {
        self.channelID = channelID
        self.channelName = channelName
        self.content = content
        self.files = files
    }
    
    enum CodingKeys: String, CodingKey {
        case channelID = "channel_id"
        case channelName
        case content
        case files
    }
    
}
