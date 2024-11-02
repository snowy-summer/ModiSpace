//
//  TokenRouter.swift
//  ModiSpace
//
//  Created by 최승범 on 11/1/24.
//

import Foundation

enum TokenRouter {
    
    case refreshToken
    
}

extension TokenRouter: RouterProtocol {

    var scheme: String { return "http" }
    
    var host: String? { return BundleManager.loadBundleValue(.host) }
    
    var path: String {
        switch self {
        case .refreshToken:
            return "/v1/auth/refresh"
        }
    }
    
    var port: Int? { return BundleManager.loadBundlePort() }
    
    var body: Data? { return nil }
    
    var query: [URLQueryItem] { return [] }
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.port = port
        components.path = path
        components.queryItems = query
        
        return components.url
    }
    
    var headers: [String : String] {
        let headers = [
            Header.sesacKey.key: Header.sesacKey.value,
            Header.refreshToken.key: Header.refreshToken.value,
            Header.authorization.key: Header.authorization.value
        ]
        return headers
    }
    
    var method: HTTPMethod { return .get }
    
    var responseType: (any Decodable.Type)? { return TokenDTO.self }
    
    var multipartFormData: [MultipartFormData] {
        return []
    }
    
}
