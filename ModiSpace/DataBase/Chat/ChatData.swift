//
//  ChatData.swift
//  ModiSpace
//
//  Created by 최승범 on 11/8/24.
//

import Foundation
import SwiftData

@Model
final class User {
    @Attribute(.unique) var userID: String
    var email: String
    var nickname: String
    var profileImage: String?

    init(userID: String,
         email: String,
         nickname: String,
         profileImage: String? = nil) {
        self.userID = userID
        self.email = email
        self.nickname = nickname
        self.profileImage = profileImage
    }
}

@Model
final class ChannelChatList {
    @Attribute(.unique) var chatID: String
    var channelID: String
    var channelName: String
    var content: String?
    var createdAt: String
    var files: [String]
    var user: User
    var isCurrentUser: Bool

    init(channelID: String,
         channelName: String,
         chatID: String,
         content: String?,
         createdAt: String,
         files: [String],
         user: User,
         isCurrentUser: Bool = false) {
        self.channelID = channelID
        self.channelName = channelName
        self.chatID = chatID
        self.content = content
        self.createdAt = createdAt
        self.files = files
        self.user = user
        self.isCurrentUser = isCurrentUser
    }
}

@Model
final class DMChatList {
    @Attribute(.unique) var dmID: String
    var roomID: String
    var content: String?
    var createdAt: String
    var files: [String]
    var user: User
    var isCurrentUser: Bool

    init(dmID: String,
         roomID: String,
         content: String?,
         createdAt: String,
         files: [String],
         user: User,
         isCurrentUser: Bool = false) {
        self.dmID = dmID
        self.roomID = roomID
        self.content = content
        self.createdAt = createdAt
        self.files = files
        self.user = user
        self.isCurrentUser = isCurrentUser
    }
}
