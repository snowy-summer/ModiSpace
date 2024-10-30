//
//  SesacStoreRouter.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/30/24.
//

import Foundation

enum SesacStoreRouter {
    
    case postStorePayValidation(body: PayvalidationRequestBody)
    case getStoreItemList
    
}

extension SesacStoreRouter: RouterProtocol {
    
    var scheme: String { return "http" }
    
    var host: String? { return BundleManager.loadBundleValue(.host) }
    
    var path: String {
        switch self {
        case .postStorePayValidation:
            return "/v1/store/item/list"
            
        case .getStoreItemList:
            return "/v1/store/pay/validation"
            
        }
    }
    
    var port: Int? { return BundleManager.loadBundlePort() }
    
    var body: Data? {
        return nil
    }
    
    var query: [URLQueryItem] {
        return []
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
        return [:]
    }
    
    var method: HTTPMethod {
        switch self {
        case .postStorePayValidation:
            return .get
            
        case .getStoreItemList:
            return .post
            
        }
    }
    
    var responseType: any Decodable.Type {
        switch self {
        case .postStorePayValidation:
            return [PayvalidationDTO].self
            
        case .getStoreItemList:
            return [ItemlistDTO].self
            
        }
    }
    
}


