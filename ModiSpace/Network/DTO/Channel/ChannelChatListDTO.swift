//
//  ChannelChatListDTO.swift
//  ModiSpace
//
//  Created by 전준영 on 10/31/24.
//

import Foundation

struct ChannelChatListDTO: Decodable, Identifiable, Equatable {
    
    var id = UUID()
    let channelID: String
    let channelName: String
    let chatID: String
    let content: String?
    let createdAt: String
    let files: [String]
    let user: OtherUserDTO
    let isCurrentUser: Bool = false
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.channelID = try container.decode(String.self, forKey: .channelID)
        self.chatID = try container.decode(String.self, forKey: .chatID)
        self.channelName = try container.decode(String.self, forKey: .channelName)
        self.content = try container.decodeIfPresent(String.self, forKey: .content)
        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.files = try container.decode([String].self, forKey: .files)
        self.user = try container.decode(OtherUserDTO.self, forKey: .user)
    }
    
    init(ChattingLogs: ChannelChatList) {
        channelID = ChattingLogs.channelID
        channelName = ChattingLogs.channelName
        chatID = ChattingLogs.chatID
        content = ChattingLogs.content
        createdAt = ChattingLogs.createdAt
        files = ChattingLogs.files
        user = OtherUserDTO(userID: ChattingLogs.user.userID,
                            email: ChattingLogs.user.email,
                            nickname: ChattingLogs.user.nickname,
                            profileImage: ChattingLogs.user.profileImage)
    }
    
    enum CodingKeys: String, CodingKey {
        case channelID = "channel_id"
        case chatID = "chat_id"
        case channelName, content, createdAt, files, user, isCurrentUser
    }
    
}

