//
//  SocketDTO.swift
//  ModiSpace
//
//  Created by 전준영 on 11/20/24.
//

import Foundation

struct SocketDTO: Decodable {
    
    let dmID: Int
    let roomID: Int
    let content: String
    let createdAt: String
    let files: [String]
    let user: SocketUser
    
    enum CodingKeys: String, CodingKey {
        case dmID = "dm_id"
        case roomID = "room_id"
        case content, createdAt, files, user
    }
    
}

struct SocketUser: Decodable {
    
    let userID: Int
    let email: String
    let nickname: String
    let profileImage: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case email, nickname, profileImage
    }
    
}
