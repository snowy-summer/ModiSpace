//
//  ChatMessageRowCell.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct ChatMessageRowCell: View {
    
    var message: DummyMessage
    
    var body: some View {
        HStack {
            if message.isCurrentUser {
                Spacer()
            } else {
                Image(systemName: message.profileImage)
                    .resizable()
                    .background(.gray)
                    .customRoundedRadius()
            }
            
            VStack(alignment: message.isCurrentUser ? .trailing : .leading) {
                Text(message.text)
                    .padding(10)
                    .background(message.isCurrentUser ? Color.blue : Color.clear)
                    .foregroundStyle(message.isCurrentUser ? .white : .black)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                
                Text("08:20 오전")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            
            if !message.isCurrentUser {
                Spacer()
            } else {
                Image(systemName: message.profileImage)
                    .resizable()
                    .background(.gray)
                    .customRoundedRadius()
            }
        }
        .padding(message.isCurrentUser ? .leading : .trailing, 60)
        .padding(.vertical, 4)
    }
    
}

