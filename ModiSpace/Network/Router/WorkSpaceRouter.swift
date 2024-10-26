//
//  WorkSpaceRouter.swift
//  ModiSpace
//
//  Created by 최승범 on 10/25/24.
//

import Foundation

enum WorkSpaceRouter {
    
    case getWorkSpaceList
    case createWorkSpace
    case getWorkSpaceInfo(spaceId: String)
    case editWorkSpace(spaceId: String)
    case deleteWorkSpace(spaceId: String)
    case inviteMember(spaceId: String)
    case findMember(spaceId: String)
    case getMemberInfo(spaceId: String, userId: String)
    case searchInWorkSpaceContent(spaceId: String)
    case changeWorkSpaceManager(spaceId: String)
    case exitWorkSpace(spaceId: String)
    
}

extension WorkSpaceRouter: RouterProtocol {
    
    var scheme: String { return "http" }
    
    var host: String { return "" }
    
    var port: Int? { return 0000 }
    
    var path: String {
        return ""
    }
    
    var query: [URLQueryItem] { return [] }
    
    var body: Data? {
        return nil
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
        case .getWorkSpaceList:
            return .get
            
        case .createWorkSpace:
            return .post
            
        case .getWorkSpaceInfo:
            return .get
            
        case .editWorkSpace:
            return .put
            
        case .deleteWorkSpace:
            return .delete
            
        case .inviteMember:
            return .post
            
        case .findMember:
            return .get
            
        case .getMemberInfo:
            return .get
            
        case .searchInWorkSpaceContent:
            return .get
            
        case .changeWorkSpaceManager:
            return .put
            
        case .exitWorkSpace:
            return .get
        }
    }
    
}
