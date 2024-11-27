//
//  DMChatModel.swift
//  ModiSpace
//
//  Created by 전준영 on 11/27/24.
//

import SwiftUI
import Combine
import SwiftData

final class DMChatModel: ObservableObject {
    
    @Published var messages: [DMSChatDTO] = []
    @Published var messageText: String = ""
    @Published var selectedImages: [UIImage] = []
    @Published var isShowingImagePicker = false
    @Published var isMemberListShow = false
    @Published var isExpiredRefreshToken = false
    
    var dms: DMSDTO
    
    private let dateManager = DateManager()
    let networkManager = NetworkManager()
    private let socketManager: SocketIOManager
    private let dbManager = DBManager()
    private let jsonDecoder = JSONDecoder()
    var cancelable = Set<AnyCancellable>()
    
    init(dms: DMSDTO) {
        self.dms = dms
        socketManager = SocketIOManager(router: SocketRouter.dm(roomID: dms.roomID))
        socketBinding()
    }
    
    func apply(_ intent: DMChatIntent) {
        switch intent {
        case .sendMessage:
            sendMessage()
            
        case .removeImage(let index):
            removeImage(at: index)
            
        case .showImagePicker(let isShowing):
            isShowingImagePicker = isShowing
            
        case .fetchMessages(let context):
            insertContext(context: context)
            fetchChattingLog()
            
        case .expiredRefreshToken:
            isExpiredRefreshToken = true
            
        case .socketConnect:
            socketManager.connect()
            
        case .socketDisconnect:
            socketManager.disconnect()
        }
    }
    
    func removeImage(at index: Int) {
        selectedImages.remove(at: index)
    }
    
}

// MARK: - DB 관련 ChatModel DB
extension DMChatModel {
    
    private func insertContext(context: ModelContext) {
        dbManager.modelContext = context
    }
    
    private func fetchDBChattingLog() -> [DMChatList] {
        let chatList = dbManager.fetchItems(ofType: DMChatList.self)
        
        var dmsChatList = chatList.filter {
            $0.roomID == dms.roomID
        }
        dmsChatList.sort {
            $0.createdAt < $1.createdAt
        }
        
        return dmsChatList
    }
    
    private func fetchChattingLog() {
        
        let dbChat = fetchDBChattingLog()
        
        for chat in dbChat {
            messages.append(DMSChatDTO(chatLogs: chat))
        }

        if dbChat.isEmpty {
            print("DB 비었음")
            fetchChatsData(cursorDate: "2024-10-18T09:30:00.722Z")
        } else {
            print("DB에서 가지고 옴")
            fetchChatsData(cursorDate: dbChat.last!.createdAt)
        }
    }
    
     func saveChattingLog() {
        for chat in messages {
            
            let user: User
            let existingUser = dbManager.fetchItems(ofType: User.self).filter { $0.userID == chat.user.userID }
            if !existingUser.isEmpty {
                user = existingUser.first!
               } else {
                   user = User(userID: chat.user.userID,
                               email: chat.user.email,
                               nickname: chat.user.nickname,
                               profileImage: chat.user.profileImage)
               }
            
            dbManager.addItem(user)
            dbManager.addItem(DMChatList(dmID: chat.dmID,
                                         roomID: chat.roomID,
                                         content: chat.content,
                                         createdAt: chat.createdAt,
                                         files: chat.files,
                                         user: user))
        }
    }
    
}

extension DMChatModel {
    // 메시지 전송 메서드
    func sendMessage() {
        guard !messageText.isEmpty || !selectedImages.isEmpty else { return }
        
        // 서버로 메시지 전송
        sendMessageserver(text: messageText,
                          images: selectedImages)

        // 텍스트와 이미지 초기화
        messageText = ""
        selectedImages = []
    }
    
}

extension DMChatModel {
    
    private func socketBinding() {
        socketManager.dataPublisher
            .receive(on: DispatchQueue.main)
            .decode(type: DMSChatDTO.self,
                    decoder: jsonDecoder)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                    
                case .failure(let error):
                    print("디코딩 에러\(error.localizedDescription)")
                }
            } receiveValue: { [weak self] value in
                self?.messages.append(value)
                self?.saveChattingLog()
            }
            .store(in: &cancelable)

    }
    
}
