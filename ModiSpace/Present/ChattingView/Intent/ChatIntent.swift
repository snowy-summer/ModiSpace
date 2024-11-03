//
//  ChatIntent.swift
//  ModiSpace
//
//  Created by 이윤지 on 11/2/24.
//

import SwiftUI

enum ChatIntent {
    case sendMessage(String, [UIImage])
    case removeImage(Int)
    case showImagePicker(Bool)
    case fetchChatsData
}
