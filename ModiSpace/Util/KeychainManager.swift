//
//  KeychainManager.swift
//  ModiSpace
//
//  Created by 최승범 on 10/31/24.
//

import Security
import Foundation

enum KeychainKey: String {
    
    case accessToken
    case refreshToken
    case deviceToken
    case userID
    
}

final class KeychainManager {
    
    static func save(_ value: String,
                     forKey key: KeychainKey) {
        delete(forKey: key)
        
        guard let data = value.data(using: .utf8) else { return }
        
        let query: NSDictionary = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrAccount : key.rawValue,
            kSecValueData : data
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        assert(status == errSecSuccess,
               "키체인 저장 실패: \(status)")
    }
    
    static  func delete(forKey key: KeychainKey) {
        let query: NSDictionary = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrAccount : key.rawValue
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        assert(status == errSecSuccess ||
               status == errSecItemNotFound,
               "키체인 삭제 실패: \(status)")
    }
    
    static func load(forKey key: KeychainKey) -> String? {
        let query: NSDictionary = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrAccount : key.rawValue,
            kSecReturnData : true,
            kSecMatchLimit : kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        guard status == errSecSuccess,
              let retrievedData = dataTypeRef as? Data,
              let value = String(data: retrievedData, encoding: .utf8) else { return nil }
        
        return value
    }
    
}
