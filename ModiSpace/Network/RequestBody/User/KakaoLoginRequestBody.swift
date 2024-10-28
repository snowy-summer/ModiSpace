//
//  KakaoLoginRequestBody.swift
//  ModiSpace
//
//  Created by 최승범 on 10/28/24.
//

import Foundation

struct KakaoLoginRequestBody: Encodable {
    
    let oauthToken: String
    let deviceToken: String
    
}
