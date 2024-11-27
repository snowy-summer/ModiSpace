//
//  DMChatMessageRowCell.swift
//  ModiSpace
//
//  Created by 전준영 on 11/26/24.
//

import SwiftUI

struct DMChatMessageRowCell: View {
    
    var message: DMSChatDTO
    var showDate: Bool
    let dateManager = DateManager()
    
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
                    
                    let isCurrentUser = (KeychainManager.load(forKey: .userID)) == message.user.userID
                    
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
                            Text(dateManager.formattedDate(from: message.createdAt))
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        
                        Text(dateManager.formattedTime(from: message.createdAt))
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
