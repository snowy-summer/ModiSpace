//
//  ImageRouter.swift
//  ModiSpace
//
//  Created by 최승범 on 11/2/24.
//

import Foundation

enum ImageRouter {
    
    case getImage(path: String)
    
}

extension ImageRouter: RouterProtocol {

    var scheme: String { return "http" }
    
    var host: String? { return BundleManager.loadBundleValue(.host) }
    
    var path: String {
        switch self {
        case .getImage(let path):
            return "/v1\(path)"
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
            Header.authorization.key: Header.authorization.value
        ]
        return headers
    }
    
    var method: HTTPMethod { return .get }
    
    var responseType: (any Decodable.Type)? { return nil }
    
    var multipartFormData: [MultipartFormData] { return [] }
    
}
