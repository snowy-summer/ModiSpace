//
//  ChattingView_Home.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct ChattingView_Home: View {
    
    @State var messages: [DummyMessage] = [
        DummyMessage(text: "저희 수료식이 언제였죠? 11/9 맞나요? 영등포 캠퍼스가 어디에 있었죠? 기억이...T.T", isCurrentUser: false, profileImage:  "person.crop.rectangle"),
        DummyMessage(text: "수료식 사진 공유드려요!", isCurrentUser: false, profileImage: "person.crop.rectangle"),
        DummyMessage(text: "하 드디어 퇴근...", isCurrentUser: true,  profileImage:  "person.crop.rectangle"),
    ]
    
    @State var messageText: String = ""
    
    var chatTitle: String
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(messages) { message in
                        ChatMessageRowCell(message: message)
                    }
                }
                .padding()
            }
            
            HStack {
                Button(action: {
                    // 사진 첨부 버튼 기능 추가 할 예정임
                }) {
                    Image(systemName: "plus")
                        .foregroundStyle(.gray)
                }
                
                TextField("메시지를 입력하세요", text: $messageText)
                    .padding(12)
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(20)
                
                Button(action: {
                    sendMessage()
                }) {
                    Image(systemName: "paperplane.fill")
                        .foregroundStyle(messageText.isEmpty ? Color.gray : Color.green)
                        .padding(5)
                }
                .disabled(messageText.isEmpty)
            }
            .padding(.horizontal, 16)
            .background(Color(UIColor.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal)
        }
        .navigationTitle(chatTitle)
        .onTapGesture {
            self.endTextEditing()
        }
        
    }
}


extension ChattingView_Home {
    
    func sendMessage() {
        if !messageText.isEmpty {
            let newMessage = DummyMessage(text: messageText, isCurrentUser: true, profileImage: "person.crop.rectangle")
            messages.append(newMessage)
            messageText = ""
        }
    }
    
}

