//
//  TokenDTO.swift
//  ModiSpace
//
//  Created by 최승범 on 10/26/24.
//

import Foundation

struct TokenDTO: Decodable {
    
    let accessToken: String
    let refreshToken: String? // 갱신시 accessToken만 값으로 들어옴
    
}
