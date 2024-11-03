//
//  ChatModel.swift
//  ModiSpace
//
//  Created by 이윤지 on 11/2/24.
//

import SwiftUI

final class ChatModel: ObservableObject {
    @Published var messages: [DummyMessage] = []  // 빈 배열로 초기화
    @Published var messageText: String = ""
    @Published var selectedImages: [UIImage] = []
    @Published var isShowingImagePicker = false

    private let networkManager = NetworkManager()
    
    func apply(_ intent: ChatIntent) {
        switch intent {
        case .sendMessage(let text, let images):
            sendMessage(text: text, images: images)
            
        case .removeImage(let index):
            removeImage(at: index)
            
        case .showImagePicker(let show):
            isShowingImagePicker = show
            
        case .fetchChatsData:
            fetchChatsData()
        }
    }

}


extension ChatModel {
    // 이전 채팅 내역을 가져오는 네트워크 함수
    private func fetchChatsData() {
        Task {
            do {
                let data = try await networkManager.getData(from: ChannelRouter.getChannelListChat(workspaceID: "", channelID: "", cursorDate: ""))
                
                let decoder = JSONDecoder()
                let list = try decoder.decode([ChannelChatListDTO].self, from: data)
                
                let newMessages = list.map { dto in
                    DummyMessage(
                        text: dto.content,
                        isCurrentUser: true,
                        profileImage: dto.user.profileImage,
                       // images: dto.files.
                        images: nil
                    )
                }
                
                DispatchQueue.main.async { [weak self] in
                    self?.messages = newMessages
                }
            } catch {
                print("Error fetching chat data: \(error)")
            }
        }
    }
}


extension ChatModel {
    // 메시지 전송 기능을 위한 별도 메서드
    private func sendMessage(text: String, images: [UIImage]) {
        guard !text.isEmpty || !images.isEmpty else { return }
        
        let newMessage = DummyMessage(text: text, isCurrentUser: false, profileImage: "person.crop.rectangle", images: []
         
        )
        messages.append(newMessage)
        messageText = ""
        selectedImages = []
    }

    // 이미지 제거 기능을 위한 별도 메서드
    private func removeImage(at index: Int) {
        guard index >= 0 && index < selectedImages.count else { return }
        selectedImages.remove(at: index)
    }
    
}
