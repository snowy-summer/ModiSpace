//
//  ChatModel.swift
//  ModiSpace
//
//  Created by 이윤지 on 11/2/24.
//

import SwiftUI
import Combine

final class ChatModel: ObservableObject {
    
    @Published var messages: [ChannelChatListDTO] = []
    @Published var messageText: String = ""
    @Published var selectedImages: [UIImage] = []
    @Published var isShowingImagePicker = false
    @Published var isShowDeleteAlertView = false
    @Published var isChannelDeleted = false
    
    let channel: ChannelDTO
    
    let networkManager = NetworkManager()
    var cancelable = Set<AnyCancellable>()
    
    init(channel: ChannelDTO) {
        self.channel = channel
    }
    
    func apply(_ intent: ChatIntent) {
        switch intent {
        case .sendMessage(let text, let images):
            sendMessage()
            
        case .removeImage(let index):
            removeImage(at: index)
            
        case .showImagePicker(let isShowing):
            isShowingImagePicker = isShowing
            
        case .fetchMessages:
            fetchChatsData()
            
        case .showDeleteAlert:
            isShowDeleteAlertView = true
            
        case .dontShowDeleteAlert:
            isShowDeleteAlertView = false
            
        case .deleteChannel:
            isShowDeleteAlertView = false
            deleteChannel()
        }
    }
    
    func removeImage(at index: Int) {
        selectedImages.remove(at: index)
    }
    
}

extension ChatModel {
    // 메시지 전송 메서드
    func sendMessage() {
        guard !messageText.isEmpty || !selectedImages.isEmpty else { return }
        
        // 서버로 메시지 전송
        sendMessageserver(text: messageText, images: selectedImages)
        
        let newMessage = ChannelChatListDTO(
            channelID: channel.channelID,
            channelName: channel.name,
            chatID: "",
            content: messageText,
            createdAt: channel.createdAt,
            files: [""],
            user: OtherUserDTO(userID: "", email: "Modispace@naver.com", nickname: "임시닉네임", profileImage: "")
        )
        messages.append(newMessage)
        
        // 텍스트와 이미지 초기화
        messageText = ""
        selectedImages = []
    }
}
