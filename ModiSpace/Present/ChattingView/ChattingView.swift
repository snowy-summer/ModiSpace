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
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(messages) { message in
                        VStack(alignment: .leading) {
                            ChatMessageRowCell(message: message)
                            
                            if let images = message.images {
                                ChatImageLayoutView(images: images)
                            }
                        }
                    }
                }
                .padding()
            }
            
            HStack {
                Button(action: {
                    isShowingImagePicker = true
                }) {
                    Image(systemName: "plus")
                        .foregroundStyle(.gray)
                }
                .sheet(isPresented: $isShowingImagePicker) {
                    PhotoPicker(selectedImages: $selectedImages)
                }
                
                VStack {
                    TextField("메시지를 입력하세요", text: $messageText)
                        .padding(12)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(20)
                    
                    if !selectedImages.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(Array(selectedImages.enumerated()), id: \.offset) { index, image in
                                    ZStack(alignment: .topTrailing) {
                                        Image(uiImage: image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 50, height: 50)
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                        
                                        Button(action: {
                                            removeImage(at: index)
                                        }) {
                                            Image(systemName: "xmark.circle.fill")
                                                .foregroundColor(.white)
                                                .background(Color.black.opacity(0.7))
                                                .clipShape(Circle())
                                        }
                                        .offset(x: 5, y: -5)
                                    }
                                }
                            }
                            .padding(.top, 4)
                        }
                    }
                }
                
                Button(action: {
                    sendMessage()
                }) {
                    Image(systemName: "paperplane.fill")
                        .foregroundStyle((messageText.isEmpty && selectedImages.isEmpty) ? Color.gray : Color.green)
                        .padding(4)
                }
                .disabled(messageText.isEmpty && selectedImages.isEmpty)
            }
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
