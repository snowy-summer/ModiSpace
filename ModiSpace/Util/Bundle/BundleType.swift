//
//  BundleType.swift
//  ModiSpace
//
//  Created by 최승범 on 10/28/24.
//

import Foundation

enum BundleType {
    
    case host
    case port
    case key
    
    var dictionaryKey: String {
        
        switch self {
        case .host:
            return "Host"
        case .port:
            return "Port"
        case .key:
            return "ApiKey"
        }
    }
    
}
