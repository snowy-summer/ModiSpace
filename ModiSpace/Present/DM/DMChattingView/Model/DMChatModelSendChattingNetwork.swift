//
//  DMChatModelSendChattingNetwork.swift
//  ModiSpace
//
//  Created by 전준영 on 11/27/24.
//

import SwiftUI
import Combine

extension DMChatModel {
    // 서버로 메시지 전송하는 실제 함수
    func sendMessageserver(text: String, images: [UIImage]) {
        let roomID = dms.roomID
        
        let imageFiles = images.compactMap { $0.jpegData(compressionQuality: 0.8) }
        let requestBody = SendDMSChatRequestBody(content: text,
                                                 files: imageFiles)
        print("값 확인: \(text), \(imageFiles)")
        
        networkManager.getDataWithPublisher(
            from: DMSRouter.sendChatDMS(workspaceID: WorkspaceIDManager.shared.workspaceID ?? "",
                                        roomID: roomID,
                                        body: requestBody)
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

extension DMChatModel {
    // 채팅 데이터 가져오기
    func fetchChatsData(cursorDate: String) {
        networkManager.getDecodedDataWithPublisher(
            from: DMSRouter.getChatListDMS(workspaceID: WorkspaceIDManager.shared.workspaceID ?? "",
                                           roomID: dms.roomID,
                                           cursorDate: cursorDate),
            type: [DMSChatDTO].self
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
            self?.messages.append(contentsOf: decodedData)
            self?.saveChattingLog()
        }
        .store(in: &cancelable)
    }
    
}
