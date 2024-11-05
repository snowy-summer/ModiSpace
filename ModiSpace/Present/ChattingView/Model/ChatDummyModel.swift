//
//  ChatDummyModel.swift
//  ModiSpace
//
//  Created by 이윤지 on 11/5/24.
//

import SwiftUI

final class ChatDummyModel: ObservableObject {
    
    private let networkManager = NetworkManager()
    
    var body: some View {
        VStack {
            Text("")
        }
    }
    
}



extension ChatDummyModel {
    
    
    
}


extension ChatDummyModel {
    func getChannelChatsData() {
        let workspaceID = "12a75244-5c0f-4478-becd-d2c95820de56"
        let channelID = "f8ff1a63-8278-4529-ac88-fea037af75aa"
        let cursorDate: String? = "2024-10-30"

        Task {
            do {
                // getDecodedData를 사용하여 `[DummyMessage]`로 디코딩된 데이터를 가져옵니다.
                let decodedMessages = try await networkManager.getDecodedData(
                    from: ChannelRouter.getChannelListChat(
                        workspaceID: workspaceID,
                        channelID: channelID,
                        cursorDate: cursorDate
                    ),
                    type: [ChannelChatListDTO].self,
                    retryCount: 3
                )

                // 메인 스레드에서 `messages` 업데이트
//                DispatchQueue.main.async {
//                    self.getChannelChatsData = decodedMessages
//                    print("데이터 가져오기 성공")
//                }
            } catch {
                print("Failed to fetch chat data:", error)
            }
        }
    }
}
