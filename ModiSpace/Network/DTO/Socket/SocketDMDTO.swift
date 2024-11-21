//
//  SocketDMDTO.swift
//  ModiSpace
//
//  Created by 전준영 on 11/20/24.
//

import Foundation

struct SocketDMDTO: Decodable {
    
    let dmID: String
    let roomID: String
    let content: String
    let createdAt: String
    let files: [String]
    let user: OtherUserDTO
    
    enum CodingKeys: String, CodingKey {
        case dmID = "dm_id"
        case roomID = "room_id"
        case content, createdAt, files, user
    }
    
}
