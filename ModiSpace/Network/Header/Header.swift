//
//  Header.swift
//  ModiSpace
//
//  Created by 최승범 on 10/25/24.
//

import Foundation

enum Header {
    
    case authorization
    case sesacKey
    case refreshToken
    case contentTypeJson
    case contentTypeMulti
    
    var key: String {
        switch self {
        case .authorization:
            return "Authorization"
            
        case .sesacKey:
            return "SesacKey"
            
        case .refreshToken:
            return "RefreshToken"
            
        case .contentTypeJson, .contentTypeMulti:
            return "Content-Type"
        }
    }
    
    var value: String {
        switch self {
        case .authorization:
            guard let token = KeychainManager.load(forKey: .accessToken) else { return "실패" }
            return token
            
        case .sesacKey:
            guard let key = BundleManager.loadBundleValue(.key) else { return "실패" }
            return key
            
        case .refreshToken:
            guard let token = KeychainManager.load(forKey: .refreshToken) else { return "실패" }
            return token
            
        case .contentTypeJson:
            return "application/json"
            
        case .contentTypeMulti:
            return "multipart/form-data"
        }
        
    }
}
