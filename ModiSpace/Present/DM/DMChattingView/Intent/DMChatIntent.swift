//
//  DMChatIntent.swift
//  ModiSpace
//
//  Created by 전준영 on 11/27/24.
//

import SwiftUI
import SwiftData

enum DMChatIntent {
    
    case sendMessage(text: String, images: [UIImage])
    case removeImage(Int)
    case showImagePicker(Bool)
    case fetchMessages(ModelContext)
    case expiredRefreshToken
    case socketConnect
    case socketDisconnect
    
}
