//
//  ChatModel_SendChatting_Network.swift
//  ModiSpace
//
//  Created by 이윤지 on 11/11/24.
//

import SwiftUI
import Combine

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
        .sink { [weak self] completion in
            switch completion {
            case .finished:
                print("메시지 전송 성공")
            case .failure(let error):
                if let apiError = error as? APIError, apiError == .refreshTokenExpired {
                    print("리프레시 토큰 만료")
                    self?.apply(.expiredRefreshToken)
                }
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
        .sink { [weak self] completion in
            switch completion {
            case .finished:
                print("채팅 데이터 로드 성공")
            case .failure(let error):
                if let apiError = error as? APIError,
                   apiError == .refreshTokenExpired {
                    print("리프레시 토큰 만료")
                    self?.apply(.expiredRefreshToken)
                }
                print("채팅 데이터 로드 실패: \(error.localizedDescription)")
            }
        } receiveValue: { [weak self] decodedData in
            self?.messages = decodedData
        }
        .store(in: &cancelable)
    }
    
}

