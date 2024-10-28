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
    case searchInWorkSpaceContent(spaceId: String, keyword: String)
    case changeWorkSpaceManager(spaceId: String)
    case exitWorkSpace(spaceId: String)
    
}

extension WorkSpaceRouter: RouterProtocol {
    
    var scheme: String { return "http" }
    
    var host: String? { return BundleManager.loadBundleValue(.host) }
    
    var port: Int? { return BundleManager.loadBundlePort() }
    
    var path: String {
        switch self {
        case .getWorkSpaceList:
            return "/v1/workspaces"
            
        case .createWorkSpace:
            return "/v1/workspaces"
            
        case .getWorkSpaceInfo(let spaceId):
            return "/v1/workspaces/\(spaceId)"
            
        case .editWorkSpace(let spaceId):
            return "/v1/workspaces/\(spaceId)"
            
        case .deleteWorkSpace(let spaceId):
            return "/v1/workspaces/\(spaceId)"
            
        case .inviteMember(let spaceId):
            return "/v1/workspaces/\(spaceId)/members"
            
        case .findMember(let spaceId):
            return "/v1/workspaces/\(spaceId)/members"
            
        case .getMemberInfo(let spaceId, let userId):
            return "/v1/workspaces/\(spaceId)/members/\(userId)"
            
        case .searchInWorkSpaceContent(let spaceId, _):
            return "/v1/workspaces/\(spaceId)/search"
            
        case .changeWorkSpaceManager(let spaceId):
            return "/v1/workspaces/\(spaceId)/transfer/ownership"
            
        case .exitWorkSpace(let spaceId):
            return "/v1/workspaces/\(spaceId)/exit"
        }
    }
    
    var query: [URLQueryItem] {
        
        switch self {
        case .searchInWorkSpaceContent(_, let keyword):
            return QueryOfWorkspaceSearch(keyword: keyword).asQueryItems()
            
        default:
            return []
        }
        
    }
    
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
    
    var responseType: Decodable.Type {
        switch self {
        case .getWorkSpaceList:
            return [WorkspaceDTO].self
            
        case .createWorkSpace:
            return WorkspaceDTO.self
            
        case .getWorkSpaceInfo:
            return WorkspaceDTO.self
            
        case .editWorkSpace:
            return WorkspaceDTO.self
            
        case .deleteWorkSpace:
            return EmptyResponseDTO.self
            
        case .inviteMember:
            return WorkspaceMemberDTO.self
            
        case .findMember:
            return [WorkspaceMemberDTO].self
            
        case .getMemberInfo:
            return WorkspaceMemberDTO.self
            
        case .searchInWorkSpaceContent:
            return WorkspaceDTO.self
            
        case .changeWorkSpaceManager:
            return WorkspaceDTO.self
            
        case .exitWorkSpace:
            return [WorkspaceDTO].self
        }
    }
    
}
