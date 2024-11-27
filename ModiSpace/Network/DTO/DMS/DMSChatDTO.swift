//
//  DMSChatDTO.swift
//  ModiSpace
//
//  Created by 전준영 on 11/1/24.
//

import Foundation

struct DMSChatDTO: Decodable, Identifiable, Equatable {
    
    var id = UUID()
    let dmID: String
    let roomID: String
    let content: String?
    let createdAt: String
    let files: [String]
    let user: OtherUserDTO
    var isCurrentUser: Bool = false
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.dmID = try container.decode(String.self, forKey: .dmID)
        self.roomID = try container.decode(String.self, forKey: .roomID)
        self.content = try container.decodeIfPresent(String.self, forKey: .content)
        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.files = try container.decode([String].self, forKey: .files)
        self.user = try container.decode(OtherUserDTO.self, forKey: .user)
    }
    
    init(chatLogs: DMChatList) {
        dmID = chatLogs.dmID
        roomID = chatLogs.roomID
        content = chatLogs.content
        createdAt = chatLogs.createdAt
        files = chatLogs.files
        user = OtherUserDTO(
            userID: chatLogs.user.userID,
            email: chatLogs.user.email,
            nickname: chatLogs.user.nickname,
            profileImage: chatLogs.user.profileImage
        )
    }
    
    enum CodingKeys: String, CodingKey {
        case dmID = "dm_id"
        case roomID = "room_id"
        case content, createdAt, files, user, isCurrentUser
    }
    
}
