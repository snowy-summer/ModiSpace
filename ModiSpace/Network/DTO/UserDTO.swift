//
//  UserDTO.swift
//  ModiSpace
//
//  Created by 최승범 on 10/27/24.
//

import Foundation

// MARK: - UserDTO
struct UserDTO: Decodable {
    
    let userID: String
    let email: String
    let nickname: String
    let profileImage: String?
    let phone: String?
    let provider: String? // 카카오, 애플 소셜제공자
    let sesacCoin: Int?
    let createdAt: String
    let token: TokenDTO
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case email, nickname, profileImage, phone, provider, createdAt, token, sesacCoin
    }
    
}


