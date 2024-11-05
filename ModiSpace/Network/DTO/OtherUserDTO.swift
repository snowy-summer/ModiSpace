//
//  OtherUserDTO.swift
//  ModiSpace
//
//  Created by 최승범 on 10/28/24.
//

import Foundation

struct OtherUserDTO: Decodable, Equatable {
    
    let userID: String
    let email: String
    let nickname: String
    let profileImage: String?
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case email, nickname, profileImage
    }
    
}


// 디바이스 토큰 -> 키체인
// 엑세스 토큰, 리프레쉬 토큰 -> 키체인
// 워크스페이스id -> 유저디폴트


// userID -> 준영님이 -> 유저디폴트

// 로그인 유형에 따라 userID를 사용하여 로그아웃 해야 함.



