//
//  ChattingView_Home.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct ChattingView: View {
    
    @StateObject var model = ChatDummyModel()
    @State var messages: [ChannelChatListDTO] = []
    @State var messageText: String = ""
    @State private var selectedImages: [UIImage] = []
    @State private var isShowingImagePicker = false
    @State private var chattingScrollListView = ChattingScrollListView(messages: .constant([]))
    
    var chatTitle: String
    private let networkManager = NetworkManager()
    
    var body: some View {
        
        VStack {
            chattingScrollListView
            
            ChatTextField(
                messageText: $messageText,
                selectedImages: $selectedImages,
                isShowingImagePicker: $isShowingImagePicker,
                onRemoveImage: removeImage
            )
            .padding(.horizontal, 16)
            .background(Color(UIColor.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal)
        }
        .navigationTitle(chatTitle)
        .onTapGesture {
            endTextEditing()
            chattingScrollListView.scrollToBottom() // 키보드 닫힐 때 마지막 메시지로 스크롤
        }
        .onAppear {
            print("fetchChatsData 실행")
            fetchChatsData()
            chattingScrollListView = ChattingScrollListView(messages: $messages) // 실제 메시지를 바인딩
        }
    }
}


//메세지 내역 받는 거
extension ChattingView {
    private func fetchChatsData() {
        Task {
            do {
                let data = try await networkManager.getData(from: ChannelRouter.getChannelListChat(workspaceID: "12a75244-5c0f-4478-becd-d2c95820de56", channelID: "f8ff1a63-8278-4529-ac88-fea037af75aa", cursorDate: "2024-10-18T09:30:00.722Z"))
                
                let decoder = JSONDecoder()
                
                // 배열 형태로 디코딩
                let list = try decoder.decode([ChannelChatListDTO].self, from: data)
                
                // 새로운 메시지 리스트를 할당
                DispatchQueue.main.async {
                    self.messages = list
                }
            } catch {
                print("채팅 내역 불러오는데 실패: \(error)")
            }
        }
    }
    
    func removeImage(at index: Int) {
           selectedImages.remove(at: index)
       }
    
    
}

#Preview {
    ChattingView(chatTitle: "Chat")
}


extension ChattingView {
    
}
