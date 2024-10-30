//
//  SesacStoreRouter.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/30/24.
//

import Foundation

enum SesacStoreRouter {
    
    case postStorePayValidation
    case getStoreItemList
    
}

extension SesacStoreRouter: RouterProtocol {
    
    var scheme: String {
        <#code#>
    }
    
    var host: String? {
        <#code#>
    }
    
    var path: String {
        switch self {
        case .postStorePayValidation:
            return "/v1/store/item/list"
            
        case .getStoreItemList:
            return "/v1/store/pay/validation"
            
        }
    }
    
    var port: Int? {
        <#code#>
    }
    
    var body: Data? {
        return nil
    }
    
    var query: [URLQueryItem] {
        <#code#>
    }
    
    var url: URL? {
        <#code#>
    }
    
    var headers: [String : String] {
        <#code#>
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
