//
//  LoginRequestBody.swift
//  ModiSpace
//
//  Created by 최승범 on 10/28/24.
//

import Foundation

struct LoginRequestBody: Encodable {
    
    let email: String
    let password: String
    let deviceToken: String
    
}
