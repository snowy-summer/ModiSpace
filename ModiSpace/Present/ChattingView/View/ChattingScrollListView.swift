//
//  ChattingListView.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/31/24.
//

import SwiftUI

struct ChattingScrollListView: View {
    
    @Binding var messages: [DummyMessage]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(messages) { message in
                    VStack(alignment: .leading) {
                        if !message.content.isEmpty {
                            ChatMessageRowCell(message: message)
                        }
                        
                        if let images = message.localFiles, !images.isEmpty {
                            ChatImageLayoutView(images: images)
                        }
                    }
                }
            }
            .padding()
        }
    }
    
}
