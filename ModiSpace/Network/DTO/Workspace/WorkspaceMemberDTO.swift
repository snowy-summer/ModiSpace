//
//  WorkspaceMemberDTO.swift
//  ModiSpace
//
//  Created by 최승범 on 10/26/24.
//

import Foundation

struct WorkspaceMemberDTO: Decodable {
    
    let userID: String
    let email: String
    let nickname: String
    let profileImage: String?
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case email, nickname, profileImage
    }
    
}
