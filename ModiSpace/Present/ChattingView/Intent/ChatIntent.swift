//
//  ChatIntent.swift
//  ModiSpace
//
//  Created by 이윤지 on 11/2/24.
//

import SwiftUI
import SwiftData

enum ChatIntent {
    case sendMessage(text: String, images: [UIImage])
    case removeImage(Int)
    case showImagePicker(Bool)
    case fetchMessages(ModelContext)
    case showDeleteAlert
    case dontShowDeleteAlert
    case deleteChannel
    case showEditChannelView
    case editChannel
    case showChangeManagerView
    case getChannelMembers
    case expiredRefreshToken
    
    case socketConnect
    case socketDisconnect
}
