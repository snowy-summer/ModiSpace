//
//  SocketRouter.swift
//  ModiSpace
//
//  Created by 최승범 on 11/11/24.
//

import Foundation

protocol SocketRoutertProtocol {
    
    var scheme: String { get }
    var host: String? { get }
    var nameSpace: String { get }
    var port: Int? { get }
    var baseURL: URL? { get }
    var event: String { get }
    var responseType: Decodable.Type { get }
    
}

enum SocketRouter {
    
    case chat(channelID: String)
    case dm(roomID: String)
    
}

extension SocketRouter: SocketRoutertProtocol {
   
    var scheme: String { return "http" }
    
    var host: String? { return BundleManager.loadBundleValue(.host) }
    
    var nameSpace: String {
        switch self {
        case .chat(let id):
            return "/ws-channel-\(id)"
            
        case .dm(let id):
            return "/ws-dm-\(id)"
        }
    }
    
    var port: Int? { return BundleManager.loadBundlePort() }
    
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
    
    var responseType: Decodable.Type {
        switch self {
        case .chat:
            return ChannelChatListDTO.self
        case .dm:
            return DMSChatDTO.self
        }
    }
    
}
