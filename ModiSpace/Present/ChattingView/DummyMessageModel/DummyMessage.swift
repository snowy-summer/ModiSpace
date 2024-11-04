//
//  DummyMessage.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct DummyMessage: Identifiable {
    let id = UUID()
    let channelId: String
    let channelName: String
    let chatId: String
    let content: String
    let createdAt: Date
    let localFiles: [UIImage]? //로컬에서 선택한 이미지
    let files: [String] //서버에서 받은 이미지
    let user: DummyUser
    let isCurrentUser: Bool
}

struct DummyUser: Identifiable {
    let id: String
    let email: String
    let nickname: String
    let profileImage: String
}

// JSON 디코딩 시 ISO8601 형식을 사용하기 위해 DateFormatter를 설정할 수 있습니다.
extension DummyMessage {
    static let dateFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()
}
