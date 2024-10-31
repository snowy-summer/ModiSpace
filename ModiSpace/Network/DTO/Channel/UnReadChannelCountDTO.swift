//
//  UnReadChannelCountDTO.swift
//  ModiSpace
//
//  Created by 전준영 on 10/31/24.
//

import Foundation

struct UnReadChannelCountDTO: Decodable {
    
    let channelID: String
    let name: String
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case channelID = "channel_id"
        case name, count
    }
    
}
