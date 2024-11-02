//
//  DMSRouter.swift
//  ModiSpace
//
//  Created by 전준영 on 11/1/24.
//

import Foundation

enum DMSRouter {
    
    case createDMS(workspaceID: String,
                   body: CreateDMSRequestBody) // DM방 조회(생성)
    case getListDMS(workspaceID: String) // DM방 리스트 조회
    case sendChatDMS(workspaceID: String,
                     roomID: String,
                     body: SendDMSChatRequestBody) // DM 채팅 보내기
    case getChatListDMS(workspaceID: String,
                        roomID: String,
                        cursorDate: String?) // DM 채팅 내역 리스트 조회
    case unReadChatDMS(workspaceID: String,
                       roomID: String,
                       after: String?) // 읽지 않은 DM 채팅 개수
    
}

extension DMSRouter: RouterProtocol {
    
    var scheme: String { return "http" }
    
    var host: String? { return BundleManager.loadBundleValue(.host) }
    
    var port: Int? { return BundleManager.loadBundlePort() }
    
    var path: String {
        switch self {
        case .createDMS(let workspaceID, _):
            return "/v1/workspaces/\(workspaceID)/dms"
            
        case .getListDMS(let workspaceID):
            return "/v1/workspaces/\(workspaceID)/dms"
            
        case .sendChatDMS(let workspaceID, let roomID, _):
            return "/v1/workspaces/\(workspaceID)/dms/\(roomID)/chats"
            
        case .getChatListDMS(let workspaceID, let roomID, _):
            return "/v1/workspaces/\(workspaceID)/dms/\(roomID)/chats"
            
        case .unReadChatDMS(let workspaceID, let roomID, _):
            return "/v1/workspaces/\(workspaceID)/dms/\(roomID)/unreads"
        }
    }
    
    var body: Data? {
        let jsonEncoder = JSONEncoder()
        var data: Data?
        
        switch self {
        case .createDMS(_, let body):
            data = try? jsonEncoder.encode(body)
            
        default:
            data = nil
        }
        
        return data
    }
    
    var query: [URLQueryItem] {
        var query = [URLQueryItem]()
        switch self {
        case .getChatListDMS(_, _, let cursorDate):
            if let cursorDate = cursorDate {
                query = QueryOfGetDMSChatList(cursorDate: cursorDate).asQueryItems()
            }
            
        case .unReadChatDMS(_, _, let after):
            if let after = after {
                query = QueryOfUnReadDMS(after: after).asQueryItems()
            }
            
        default:
            query = []
        }
        
        return query
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
            Header.sesacKey.key: Header.sesacKey.value,
            Header.authorization.key: Header.authorization.value
        ]
        
        switch self {
        case .sendChatDMS:
            headers.updateValue(Header.contentTypeMulti.value,
                                forKey: Header.contentTypeMulti.key)
            
        default:
            headers.updateValue(Header.contentTypeJson.value,
                                forKey: Header.contentTypeJson.key)
        }
        
        return headers
    }
    
    var method: HTTPMethod {
        switch self {
        case .createDMS, .sendChatDMS:
            return .post
            
        case .getListDMS, .getChatListDMS, .unReadChatDMS:
            return .get
        }
    }
    
    var responseType: (any Decodable.Type)? {
        switch self {
        case .createDMS:
            return DMSDTO.self
        case .getListDMS:
            return [DMSDTO].self
        case .sendChatDMS:
            return DMSChatDTO.self
        case .getChatListDMS:
            return [DMSChatDTO].self
        case .unReadChatDMS:
            return DMSUnreadCountDTO.self
        }
    }
    
    var multipartFormData: [MultipartFormData] {
        switch self {
        case .sendChatDMS(_, _, let body):
            return body.toMultipartFormData()
            
        default:
            return []
        }
    }
    
}
