//
//  ChatModel_SettingChat_Network.swift
//  ModiSpace
//
//  Created by 이윤지 on 11/11/24.
//

import SwiftUI
import Combine

extension ChatModel {
    
    func deleteChannel() {
        networkManager.getDataWithPublisher(from: ChannelRouter.deleteSpecificChannel(workspaceID: WorkspaceIDManager.shared.workspaceID ?? "", channelID: channel.channelID))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    print("채널 삭제 성공")
                    self?.isChannelDeleted = true
                case .failure(let error):
                    if let error = error as? NetworkError {
                        print(error.description)
                    }
                    if let error = error as? APIError, error == .refreshTokenExpired {
                        print("리프레시 토큰 만료")
                        self?.apply(.expiredRefreshToken)
                    }
                    print(error.localizedDescription)
                }
            } receiveValue: { _ in
                
            }
            .store(in: &cancelable)
    }
    
}
