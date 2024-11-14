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
    @Published var isShowingEditChannelView = false
    //@Published var sheetType: ChatViewSheetType?
    @Published var channelMembers: [OtherUserDTO] = []
    
    var channel: ChannelDTO
    
    var isEditAble: Bool {
        !channel.name.isEmpty
    }
    
    private let dateManager = DateManager()
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
            
        case .showEditChannelView:
            isShowingEditChannelView = true
            
        case .editChannel:
            editingChannel()
            
        case .getChannelMembers:
            getChannelMembers()
            
            // case .showChangeManagerView:
            //sheetType = .changeChannelManager
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
            createdAt: dateManager.string(from: Date()),
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
    
    func getChannelMembers() {
        
        networkManager.getDecodedDataWithPublisher(from: ChannelRouter.getChannelMember(workspaceID: WorkspaceIDManager.shared.workspaceID ?? "", channelID: channel.channelID),
                                                   type: [OtherUserDTO].self)
        .receive(on: DispatchQueue.main)
        .sink { completion in
            switch completion {
            case .finished:
                // break
                print("네트워크 요청 성공: 채널 멤버 데이터를 성공적으로 가져왔습니다.")
            case .failure(let error):
                if let error = error as? NetworkError {
                    print(error.description)
                }
                if let error = error as? APIError {
                    if error == .refreshTokenExpired {
                        print("리프레시 토큰 만료")
                    }
                }
                print(error.localizedDescription)
                print("실패")
            }
        } receiveValue: { [weak self] value in
            self?.channelMembers = value
            
        }.store(in: &cancelable)
    }
    
}

extension ChatModel {
    //수정된 채널 설정 서버에 반영하기
    func editingChannel() {
        let emptyData = Data() //이미지 뭐 넣어야 되는지 모르겠음  channel.coverImage 이거 인가?
        Task {
            do {
                let router = ChannelRouter.editSpecificChannel(workspaceID: WorkspaceIDManager.shared.workspaceID ?? "", channelID: channel.channelID, body: PostChannelRequestBody(name: channel.name, description: channel.description, image: emptyData))
                
                let _ = try await
                NetworkManager().getDecodedData(from: router, type: ChannelDTO.self)
            } catch(let error) {
                print(error.localizedDescription)
            }
        }
    }
    
}



