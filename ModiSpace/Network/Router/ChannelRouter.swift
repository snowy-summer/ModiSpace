//
//  ChannelRouter.swift
//  ModiSpace
//
//  Created by 전준영 on 10/30/24.
//

import Foundation

enum ChannelRouter {
    
    case myChannelList(workspaceID: String) // 내가 속한 채널 리스트 조회
    case getChannelList(workspaceID: String) // 채널 리스트 조회
    case postChannel(workspaceID: String,
                     body: PostChannelRequestBody) // 채널 생성
    case getSpecificChannel(workspaceID: String,
                            channelID: String) // 특정 채널 정보 조회
    case editSpecificChannel(workspaceID: String,
                             channelID: String,
                             body: PostChannelRequestBody) // 채널 편집
    case deleteSpecificChannel(workspaceID: String,
                               channelID: String) // 채널 삭제
    case getChannelListChat(workspaceID: String,
                            channelID: String,
                            cursorDate: String?) // 채팅채널 리스트 조회
    case sendChannelChat(workspaceID: String,
                         channelID: String,
                         body: SendChannelRequestBody) // 채널 채팅 보내기
    case unReadCountChat(workspaceID: String,
                         channelID: String,
                         after: String?) // 읽지 않은 채널 채팅 갯수
    case getChannelMember(workspaceID: String,
                          channelID: String) // 채널 멤버 조회
    case channelOwnershipTransfer(workspaceID: String,
                                  channelID: String,
                                  body: OwnershipTransferRequestBody) // 채널 관리자 변경
    case exitChannel(workspaceID: String,
                     channelID: String) // 채널 나가기
    
}

extension ChannelRouter: RouterProtocol {
    
    var scheme: String { return "http" }
    
    var host: String? { return BundleManager.loadBundleValue(.host) }
    
    var port: Int? { return BundleManager.loadBundlePort() }
    
    var path: String {
        switch self {
        case .myChannelList(let workspaceID):
            return "/v1/workspaces/\(workspaceID)/my-channels"
            
        case .getChannelList(let workspaceID):
            return "/v1/workspaces/\(workspaceID)/channels"
            
        case .postChannel(let workspaceID, _):
            return "/v1/workspaces/\(workspaceID)/channels"
            
        case .getSpecificChannel(let workspaceID, let channelID):
            return "/v1/workspaces/\(workspaceID)/channels/\(channelID)"
            
        case .editSpecificChannel(let workspaceID, let channelID, _):
            return "/v1/workspaces/\(workspaceID)/channels/\(channelID)"
            
        case .deleteSpecificChannel(let workspaceID, let channelID):
            return "/v1/workspaces/\(workspaceID)/channels/\(channelID)"
            
        case .getChannelListChat(let workspaceID, let channelID, _):
            return "/v1/workspaces/\(workspaceID)/channels/\(channelID)/chats"
            
        case .sendChannelChat(let workspaceID, let channelID, _):
            return "/v1/workspaces/\(workspaceID)/channels/\(channelID)/chats"
            
        case .unReadCountChat(let workspaceID, let channelID, _):
            return "/v1/workspaces/\(workspaceID)/channels/\(channelID)/unreads"
            
        case .getChannelMember(let workspaceID, let channelID):
            return "/v1/workspaces/\(workspaceID)/channels/\(channelID)/members"
            
        case .channelOwnershipTransfer(let workspaceID, let channelID, _):
            return "/v1/workspaces/\(workspaceID)/channels/\(channelID)/transfer/ownership"
            
        case .exitChannel(let workspaceID, let channelID):
            return "/v1/workspaces/\(workspaceID)/channels/\(channelID)/exit"
        }
    }
    
    var body: Data? {
        
        let jsonEncoder = JSONEncoder()
        var data: Data?
        
        switch self {
        case .getSpecificChannel(_, let body):
            data = try? jsonEncoder.encode(body)
            
        case .channelOwnershipTransfer(_, _, let body):
            data = try? jsonEncoder.encode(body)
            
        default:
            data = nil
        }
        
        return data
    }
    
    var query: [URLQueryItem] {
        switch self {
        case .getChannelListChat(_, _, let cursorDate):
            if let cursorDate = cursorDate {
                return QueryOfGetChannelChatList(cursorDate: cursorDate).asQueryItems()
            } else {
                return []
            }
            
        case .unReadCountChat(_, _, let after):
            if let after = after {
                return QueryOfUnReadChannel(after: after).asQueryItems()
            } else {
                return []
            }
            
        default:
            return []
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
            Header.contentTypeJson.key: Header.contentTypeJson.value
        ]
        
        return headers
    }
    
    var method: HTTPMethod {
        switch self {
        case .myChannelList,
                .getChannelList,
                .getSpecificChannel,
                .getChannelListChat,
                .unReadCountChat,
                .getChannelMember,
                .exitChannel:
            return .get
            
        case .postChannel,
                .sendChannelChat:
            return .post
            
        case .editSpecificChannel,
                .channelOwnershipTransfer:
            return .put
            
        case .deleteSpecificChannel:
            return .delete
        }
    }
    
    var responseType: (any Decodable.Type)? {
        switch self {
        case .myChannelList, .getChannelList, .exitChannel:
            return [ChannelDTO].self
            
        case .postChannel, .editSpecificChannel:
            return ChannelDTO.self
            
        case .getSpecificChannel:
            return SpecificChannelDTO.self
            
        case .getChannelListChat:
            return [ChannelChatListDTO].self
            
        case .sendChannelChat:
            return ChannelChatListDTO.self
            
        case .unReadCountChat:
            return UnReadChannelCountDTO.self
            
        case .getChannelMember:
            return [OtherUserDTO].self
            
        case .channelOwnershipTransfer:
            return OwnershipTransferDTO.self
            
        case .deleteSpecificChannel:
            return nil
        }
    }
    
    var multipartFormData: [MultipartFormData] {
        switch self {
        case .postChannel(_, let body):
            return body.toMultipartFormData()
            
        case .editSpecificChannel(_, _, let body):
            return body.toMultipartFormData()
            
        case .sendChannelChat(_, _, let body):
            return body.toMultipartFormData()
            
        default:
            return []
        }
    }
    
}
