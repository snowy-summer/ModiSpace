//
//  NetworkError.swift
//  ModiSpace
//
//  Created by 최승범 on 10/26/24.
//

import Foundation

enum NetworkError: Error, CustomStringConvertible {
    
    case invalidURL
    case invalidResponse
    case decodingFailed(String)
    
}

extension NetworkError {
    
    var description: String {
        switch self {
        case .invalidURL:
            return "잘못된 URL입니다"
        case .invalidResponse:
            return "잘못된 응답입니다"
        case .decodingFailed(let type):
            return "디코딩에 실패했습니다 타입: \(type)"
        }
    }
}
