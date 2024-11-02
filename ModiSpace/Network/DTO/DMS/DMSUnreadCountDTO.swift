//
//  DMSUnreadCountDTO.swift
//  ModiSpace
//
//  Created by 전준영 on 11/1/24.
//

import Foundation

struct DMSUnreadCountDTO: Decodable {
    
    let roomID: String
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case roomID = "room_id"
        case count
    }
    
}
