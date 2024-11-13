//
//  UserProfileDTO.swift
//  ModiSpace
//
//  Created by 전준영 on 11/13/24.
//

import Foundation

struct UserProfileDTO: Decodable {
    
    let userID: String
    let email: String
    let nickname: String
    let profileImage: String?
    let phone: String?
    let provider: String? // 카카오, 애플 소셜제공자
    let sesacCoin: Int?
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case email, nickname, profileImage, phone, provider, createdAt, sesacCoin
    }
    
}
