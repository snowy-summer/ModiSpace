//
//  ChatMessageRowCell.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct ChatMessageRowCell: View {
    
    var message: ChannelChatListDTO
    var showDate: Bool
    
    var body: some View {
        HStack {
            if message.isCurrentUser {
                Spacer()
            } else {
                
                Image("tempImage")
                    .resizable()
                    .background(.gray)
                    .customRoundedRadius()
            }
            
            VStack(alignment: message.isCurrentUser ? .trailing : .leading) {
                if let content = message.content {
                    Text(message.user.nickname)
                        .font(.caption)
                        .bold()
                    
                    let isCurrentUser = (KeychainManager.load(forKey: .userID) as? String) == message.user.userID
                    
                    Text(content)
                        .padding(10)
                        .background(isCurrentUser ? .blue : .clear)
                        .foregroundStyle(isCurrentUser ? .white : .black)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(.gray, lineWidth: 1)
                        )
                    
                    HStack {
                        if showDate {
                            Text(formattedDate(from: message.createdAt))
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        
                        Text(formattedTime(from: message.createdAt))
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                }
            }
            if !message.isCurrentUser {
                Spacer()
            } else {
                // Image(systemName: message.profileImage)
                Image(systemName: "star")
                    .resizable()
                    .background(.gray)
                    .customRoundedRadius()
            }
        }
        .padding(message.isCurrentUser ? .leading : .trailing, 60)
        .padding(.vertical, 4)
    }
    
}
