//
//  ChatMessageRowCell.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct ChatMessageRowCell: View {
    
    var message: ChannelChatListDTO
    
    var body: some View {
        HStack {
            if message.isCurrentUser {
                Spacer()
            } else {
               // Image(na: message.profileImage)
                Image(systemName: "star")
                    .resizable()
                    .background(.gray)
                    .customRoundedRadius()
            }
            
            VStack(alignment: message.isCurrentUser ? .trailing : .leading) {
                if let content = message.content {
                    Text(content)
                        .padding(10)
                        .background(message.isCurrentUser ? Color.blue : Color.clear)
                        .foregroundStyle(message.isCurrentUser ? .white : .black)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    
                    Text(formattedTime(from: message.createdAt))
                        .font(.caption)
                        .foregroundStyle(.gray)
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

extension ChatMessageRowCell {
    
    private func formattedTime(from dateString: String) -> String {
          let inputFormatter = DateFormatter()
          inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
          
          let outputFormatter = DateFormatter()
          outputFormatter.dateFormat = "a hh:mm"
          
          if let date = inputFormatter.date(from: dateString) {
              return outputFormatter.string(from: date)
          } else {
              return dateString
          }
      }
    
}
