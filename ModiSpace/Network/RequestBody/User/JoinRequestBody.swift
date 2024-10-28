//
//  JoinRequestBody.swift
//  ModiSpace
//
//  Created by 최승범 on 10/28/24.
//

import Foundation

struct JoinRequestBody: Encodable {
    
    let email: String
    let password: String
    let nickname: String
    let phone: String
    let deviceToken: String
    
}
