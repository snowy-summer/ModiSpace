//
//  WorkspaceDTO.swift
//  ModiSpace
//
//  Created by 최승범 on 10/26/24.
//

import Foundation

struct WorkspaceDTO: Decodable {
    
    let workspaceID: String
    let name: String
    let description: String
    let coverImage: String
    let ownerID: String
    var createdAt: String
    let channels: [ChannelDTO]
    let workspaceMembers: [WorkspaceMemberDTO]
    
    enum CodingKeys: String, CodingKey {
        case workspaceID = "workspace_id"
        case name, description, coverImage
        case ownerID = "owner_id"
        case createdAt, channels, workspaceMembers
    }
    
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            workspaceID = try container.decode(String.self, forKey: .workspaceID)
            name = try container.decode(String.self, forKey: .name)
            description = try container.decode(String.self, forKey: .description)
            coverImage = try container.decode(String.self, forKey: .coverImage)
            ownerID = try container.decode(String.self, forKey: .ownerID)
            createdAt = try container.decode(String.self, forKey: .createdAt)
            channels = try container.decodeIfPresent([ChannelDTO].self, forKey: .channels) ?? []
            workspaceMembers = try container.decodeIfPresent([WorkspaceMemberDTO].self, forKey: .workspaceMembers) ?? []
        }
    
}
