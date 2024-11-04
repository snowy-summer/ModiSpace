//
//  ChattingView_Home.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct ChattingView: View {
    
    @State var messages: [DummyMessage] = [
        DummyMessage(
            channelId: "f8ff1a63-8278-4529-ac88-fea037af75aa",
            channelName: "General",
            chatId: "chat1",
            content: "안녕하세요! 테스트 메시지입니다.",
            createdAt: Date(),
            localFiles: [],
            files: [], //서버에서 받은 이미지
            user: DummyUser(
                id: "user1",
                email: "user1@example.com",
                nickname: "Alice",
                profileImage: "https://example.com/image1.png"
            ),
            isCurrentUser: false
        ),
        
        DummyMessage(
            channelId: "f8ff1a63-8278-4529-ac88-fea037af75aa",
            channelName: "General",
            chatId: "chat2",
            content: "안녕하세요, Alice! 반가워요!",
            createdAt: Date().addingTimeInterval(-3600),
            localFiles: [],
            files: [], //서버에서 받은 이미지
            user: DummyUser(
                id: "user2",
                email: "user2@example.com",
                nickname: "Bob",
                profileImage: "https://example.com/image2.png"
            ),
            isCurrentUser: true
        ),
        
        DummyMessage(
            channelId: "f8ff1a63-8278-4529-ac88-fea037af75aa",
            channelName: "Random",
            chatId: "chat3",
            content: "최신 업데이트 보셨나요?",
            createdAt: Date().addingTimeInterval(-7200),
            localFiles: [],
            files: [], //서버에서 받은 이미지
            user: DummyUser(
                id: "user3",
                email: "user3@example.com",
                nickname: "Charlie",
                profileImage: "https://example.com/image3.png"
            ),
            isCurrentUser: false
        )
    ]
    
    @State var messageText: String = ""
    @State private var selectedImages: [UIImage] = []
    @State private var isShowingImagePicker = false
    
    var chatTitle: String
    
    var body: some View {
        VStack {
            ChattingScrollListView(messages: $messages)
            
            ChatTextField(
                           messageText: $messageText,
                           selectedImages: $selectedImages,
                           isShowingImagePicker: $isShowingImagePicker,
                           onSendMessage: sendMessage,
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
        }
    }
    
}

//메세지 보낼 때 셀
extension ChattingView {
    
    func sendMessage() {
          if !messageText.isEmpty || !selectedImages.isEmpty {
              let newMessage = DummyMessage(
                  channelId: "f8ff1a63-8278-4529-ac88-fea037af75aa",
                  channelName: "Chat Channel",
                  chatId: UUID().uuidString,
                  content: messageText,
                  createdAt: Date(),
                  localFiles: selectedImages,
                  files: [], //서버에서 받은 이미지
                  user: DummyUser(
                      id: "currentUser",
                      email: "currentUser@example.com",
                      nickname: "Me",
                      profileImage: "star"
                  ),
                  isCurrentUser: true
              )
              messages.append(newMessage)
              messageText = ""
              selectedImages = []
          }
      }
    
    
    func removeImage(at index: Int) {
        selectedImages.remove(at: index)
    }
    
}

#Preview {
    ChattingView(chatTitle: "Chat")
}
