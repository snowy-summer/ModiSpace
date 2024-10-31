//
//  WorkSpaceRouter.swift
//  ModiSpace
//
//  Created by 최승범 on 10/25/24.
//

import Foundation

enum WorkSpaceRouter {
    
    case getWorkSpaceList
    case createWorkSpace(body: WorkspaceRequestBody)
    case getWorkSpaceInfo(spaceId: String)
    case editWorkSpace(spaceId: String,
                       body: WorkspaceRequestBody)
    case deleteWorkSpace(spaceId: String)
    case inviteMember(spaceId: String,
                      body: InviteMemberRequestBody)
    case findMember(spaceId: String)
    case getMemberInfo(spaceId: String,
                       userId: String)
    case searchInWorkSpaceContent(spaceId: String,
                                  keyword: String)
    case changeWorkSpaceManager(spaceId: String,
                                body: ChangeWorkspaceManagerRequestBody)
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
            
        case .editWorkSpace(let spaceId, _):
            return "/v1/workspaces/\(spaceId)"
            
        case .deleteWorkSpace(let spaceId):
            return "/v1/workspaces/\(spaceId)"
            
        case .inviteMember(let spaceId, _):
            return "/v1/workspaces/\(spaceId)/members"
            
        case .findMember(let spaceId):
            return "/v1/workspaces/\(spaceId)/members"
            
        case .getMemberInfo(let spaceId, let userId):
            return "/v1/workspaces/\(spaceId)/members/\(userId)"
            
        case .searchInWorkSpaceContent(let spaceId, _):
            return "/v1/workspaces/\(spaceId)/search"
            
        case .changeWorkSpaceManager(let spaceId, _):
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
        let jsonEncoder = JSONEncoder()
        var data: Data?
        
        switch self {
        case .editWorkSpace(_, let body):
            data = try? jsonEncoder.encode(body)
            
        case .inviteMember(_, let body):
            data = try? jsonEncoder.encode(body)
            
        case .changeWorkSpaceManager(_, let body):
            data = try? jsonEncoder.encode(body)
            
        default:
            data = nil
        }
    
        return data
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
        var headers = [
            Header.sesacKey.key : Header.sesacKey.value,
        ]
        
        switch self {
        case .getWorkSpaceList:
            headers.updateValue(Header.authorization.value,
                                forKey: Header.authorization.key)
            
        case .createWorkSpace:
            headers.updateValue(Header.authorization.value,
                                forKey: Header.authorization.key)
            headers.updateValue(Header.contentTypeMulti.value,
                                forKey: Header.contentTypeMulti.key)
            
        case .editWorkSpace:
            headers.updateValue(Header.authorization.value,
                                forKey: Header.authorization.key)
            headers.updateValue(Header.contentTypeMulti.value,
                                forKey: Header.contentTypeMulti.key)
            
        case .changeWorkSpaceManager:
            headers.updateValue(Header.authorization.value,
                                forKey: Header.authorization.key)
            headers.updateValue(Header.contentTypeMulti.value,
                                forKey: Header.contentTypeMulti.key)
            
        case .exitWorkSpace:
            headers.updateValue(Header.authorization.value,
                                forKey: Header.authorization.key)
            headers.updateValue(Header.contentTypeMulti.value,
                                forKey: Header.contentTypeMulti.key)
            
        default:
            return headers
        }
        
        return headers
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
    
    var responseType: Decodable.Type? {
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
            return nil
            
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
    
    var multipartFormData: [MultipartFormData] {
        switch self {
        case .createWorkSpace(let body):
            return body.toMultipartFormData()
        case .editWorkSpace(_, let body):
            return body.toMultipartFormData()
        default:
            return []
        }
    }
    
}
