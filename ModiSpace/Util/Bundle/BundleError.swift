//
//  BundleError.swift
//  ModiSpace
//
//  Created by 최승범 on 10/28/24.
//

import Foundation

enum BundleError: Error, CustomStringConvertible {
    
    case keyNotFound
    
    var description: String {
        
        switch self {
        case .keyNotFound:
            return "Bundle Key가 잘못된 것 같습니다"
        }
    }
    
}
