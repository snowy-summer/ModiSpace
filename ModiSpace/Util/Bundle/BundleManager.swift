//
//  BundleManager.swift
//  ModiSpace
//
//  Created by 최승범 on 10/28/24.
//

import Foundation

final class BundleManager {
    
    static func loadBundleValue(_ type: BundleType) -> String? {
        let value = Bundle.main.object(forInfoDictionaryKey: type.dictionaryKey) as? String
        
        return value
    }
    
    static func loadBundlePort() -> Int? {
        
        if let value = loadBundleValue(.port),
           let port = Int(value) {
            
            return port
        }
        
        return nil
    }
    
}
