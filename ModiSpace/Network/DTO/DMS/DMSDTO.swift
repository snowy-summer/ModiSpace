//
//  DMSDTO.swift
//  ModiSpace
//
//  Created by 전준영 on 11/1/24.
//

import Foundation

struct DMSDTO: Decodable {
    
    let roomID: String
    let createdAt: String
    let user: OtherUserDTO
    
    enum CodingKeys: String, CodingKey {
        case roomID = "room_id"
        case createdAt, user
    }
    
}
