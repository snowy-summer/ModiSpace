//
//  SpecificChannelDTO.swift
//  ModiSpace
//
//  Created by 전준영 on 10/31/24.
//

import Foundation

struct SpecificChannelDTO: Decodable {
    
    let channelID: String
    let name: String
    let description: String
    let coverImage: String
    let ownerID: String
    let createdAt: String
    let channelMembers: [OtherUserDTO]
    
}
