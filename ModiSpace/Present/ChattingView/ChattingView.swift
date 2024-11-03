//
//  ChattingView_Home.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct ChattingView: View {
    
    @StateObject private var model = ChatModel()
    var chatTitle: String
    
    var body: some View {
        VStack {
            ChattingScrollListView(messages: $model.messages)
            
            ChatTextField(
                messageText: $model.messageText,
                selectedImages: $model.selectedImages,
                isShowingImagePicker: $model.isShowingImagePicker,
                onSendMessage: { model.apply(.sendMessage(model.messageText, model.selectedImages)) },
                onRemoveImage: { index in model.apply(.removeImage(index)) }
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
//extension ChattingView {
//    
//    func sendMessage() {
//        if !messageText.isEmpty || !selectedImages.isEmpty {
//            let newMessage = DummyMessage(
//                text: messageText,
//                isCurrentUser: true,
//                profileImage: "person.crop.rectangle",
//                images: selectedImages.isEmpty ? nil : selectedImages
//            )
//            messages.append(newMessage)
//            messageText = ""
//            selectedImages = []
//        }
//    }
//    
//    func removeImage(at index: Int) {
//        selectedImages.remove(at: index)
//    }
//    
//}

#Preview {
    ChattingView(chatTitle: "Chat")
}
