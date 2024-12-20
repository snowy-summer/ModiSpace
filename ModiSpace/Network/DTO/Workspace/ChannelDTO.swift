//
//  ChannelDTO.swift
//  ModiSpace
//
//  Created by 최승범 on 10/26/24.
//

import Foundation

struct ChannelDTO: Decodable {
    
    let channelID: String
    var name: String
    var description: String?
    let coverImage: String?
    let ownerID: String
    let createdAt: String
    var unreadChannelCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case channelID = "channel_id"
        case name, description, coverImage
        case ownerID = "owner_id"
        case createdAt, unreadChannelCount
    }
    
}
