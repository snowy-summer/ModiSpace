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
                        ChatMessageRowCell(message: message)
                        
                        if let images = message.images {
                            ChatImageLayoutView(images: images)
                        }
                    }
                }
            }
            .padding()
        }
    }
    
}
