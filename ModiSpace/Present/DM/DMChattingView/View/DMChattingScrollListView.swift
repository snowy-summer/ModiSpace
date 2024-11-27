//
//  DMChattingScrollListView.swift
//  ModiSpace
//
//  Created by 전준영 on 11/27/24.
//

import SwiftUI

struct DMChattingScrollListView: View {
    
    @Binding var messages: [DMSChatDTO]
    @State private var proxy: ScrollViewProxy? = nil
    
    var body: some View {
        ScrollViewReader { scrollProxy in
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(messages) { message in
                        VStack(alignment: .leading) {
                            if let content = message.content, !content.isEmpty {
                                DMChatMessageRowCell(message: message, showDate: true)
                            }
                            // 이미지 파일이 있는 경우 처리
                            // if let images = message.files, !images.isEmpty {
                            //     ChatImageLayoutView(images: images)
                            // }
                        }
                        .id(message.id) // 각 메시지에 고유 ID를 추가
                    }
                }
                .padding()
                .onAppear {
                    self.proxy = scrollProxy
                    scrollToBottom() // 처음 로드 시 마지막으로 스크롤
                    print("messages : \(messages)")
                }
                .onChange(of: messages) { _ in
                    scrollToBottom() // 메시지가 추가될 때마다 스크롤
                }
            }
        }
    }

}

extension DMChattingScrollListView {
    
    func scrollToBottom() {
        if let lastMessage = messages.last {
            withAnimation {
                proxy?.scrollTo(lastMessage.id, anchor: .bottom)
            }
        }
    }
    
}
