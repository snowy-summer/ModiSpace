//
//  ChattingView_Home.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct ChattingView: View {
    
    @State var messages: [DummyMessage] = [
        DummyMessage(text: "저희 수료식이 언제였죠? 11/9 맞나요? 영등포 캠퍼스가 어디에 있었죠? 기억이...T.T", isCurrentUser: false, profileImage: "person.crop.rectangle", images: nil),
        DummyMessage(text: "수료식 사진 공유드려요!", isCurrentUser: false, profileImage: "person.crop.rectangle", images: nil),
        DummyMessage(text: "하 드디어 퇴근...", isCurrentUser: true, profileImage: "person.crop.rectangle", images: nil),
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
                text: messageText,
                isCurrentUser: true,
                profileImage: "person.crop.rectangle",
                images: selectedImages.isEmpty ? nil : selectedImages
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
