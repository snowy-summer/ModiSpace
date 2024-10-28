//
//  OtherUserDTO.swift
//  ModiSpace
//
//  Created by 최승범 on 10/28/24.
//

import Foundation

struct OtherUserDTO: Decodable {
    
    let userID: String
    let email: String
    let nickname: String
    let profileImage: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case email, nickname, profileImage
    }
    
}
