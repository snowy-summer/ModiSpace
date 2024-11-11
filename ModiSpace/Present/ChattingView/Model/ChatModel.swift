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
    
    let channel: ChannelDTO
    
    private let networkManager = NetworkManager()
    private var cancelable = Set<AnyCancellable>()
    
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

extension ChatModel {
    // 서버로 메시지 전송하는 실제 함수
    func sendMessageserver(text: String, images: [UIImage]) {
        let workspaceID = WorkspaceIDManager.shared.workspaceID
        let channelID = channel.channelID
        
        let imageFiles = images.compactMap { $0.jpegData(compressionQuality: 0.8) }
        let requestBody = SendChannelChatRequestBody(content: text, files: imageFiles)
        print(text, imageFiles)
        
        networkManager.getDataWithPublisher(
            from: ChannelRouter.sendChannelChat(
                workspaceID: WorkspaceIDManager.shared.workspaceID ?? "",
                channelID: channelID,
                body: requestBody
            )
        )
        .receive(on: DispatchQueue.main)
        .sink { completion in
            switch completion {
            case .finished:
                print("메시지 전송 성공")
            case .failure(let error):
                print("메시지 전송 실패: \(error.localizedDescription)")
            }
        } receiveValue: { value in
            print("서버 응답: \(value)")
        }
        .store(in: &cancelable)
    }
    
}


extension ChatModel {
    // 채팅 데이터 가져오기
    func fetchChatsData() {
        networkManager.getDecodedDataWithPublisher(
            from: ChannelRouter.getChannelListChat(workspaceID: WorkspaceIDManager.shared.workspaceID ?? "",
                                                   channelID: channel.channelID,
                                                   cursorDate: "2024-10-18T09:30:00.722Z"),
            type: [ChannelChatListDTO].self
        )
        .receive(on: DispatchQueue.main)
        .sink { completion in
            if case .failure(let error) = completion {
                print("채팅 데이터 로드 실패: \(error.localizedDescription)")
            }
        } receiveValue: { [weak self] decodedData in
            self?.messages = decodedData
            //print("채팅 데이터 로드 성공")
            //print(decodedData)
        }
        .store(in: &cancelable)
    }
}
