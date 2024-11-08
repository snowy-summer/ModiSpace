//
//  ChattingView_Home.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct ChattingView: View {
    
    @StateObject var model = ChatModel()
    
    var chatTitle: String

    var body: some View {
        VStack {
            ChattingScrollListView(messages: $model.messages)

            ChatTextField(
                messageText: $model.messageText,
                selectedImages: $model.selectedImages,
                isShowingImagePicker: $model.isShowingImagePicker,
                onSendMessage: model.sendMessage,
                onRemoveImage: model.removeImage
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
        .onAppear {
            model.fetchChatsData()
        }
    }
    
}

extension ChattingView {
    func removeImage(at index: Int) {
        model.selectedImages.remove(at: index)
    }
    
}
