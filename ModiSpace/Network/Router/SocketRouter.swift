//
//  SocketRouter.swift
//  ModiSpace
//
//  Created by 최승범 on 11/11/24.
//

import Foundation

protocol SockeRoutertProtocol: RouterProtocol {
    
    var baseURL: URL? { get }
    var event: String { get }
    
}

enum SocketRouter {
    
    case chat(channelID: String)
    case dm(roomID: String)
    
}

extension SocketRouter: SockeRoutertProtocol {
    
    var scheme: String { return "http" }
    
    var host: String? { return BundleManager.loadBundleValue(.host) }
    
    var path: String {
        switch self {
        case .chat(let id):
            return "/ws-channel-\(id)"
            
        case .dm(let id):
            return "/ws-dm-\(id)"
        }
    }
    
    var port: Int? { return BundleManager.loadBundlePort() }
    
    var body: Data? { return nil }
    
    var query: [URLQueryItem] { return [] }
    
    var baseURL: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.port = port
        
        return components.url
    }
    
    var event: String {
        switch self {
        case .chat:
            return "channel"
            
        case .dm:
            return "dm"
        }
    }
    
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
