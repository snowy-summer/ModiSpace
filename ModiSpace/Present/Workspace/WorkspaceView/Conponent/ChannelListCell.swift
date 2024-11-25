//
//  ChannelListCell.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct ChannelListCell: View {
    
    var channelTitle: String
    var unreadChannelCount: Int?
    
    var body: some View {
        HStack {
            Image(systemName: "number")
            
            Text(channelTitle)
                .font(.system(size: 16))
            
            Spacer()
            
            if let badge = unreadChannelCount {
                Text("\(badge)")
                    .font(.system(size: 12))
                    .foregroundStyle(.white)
                    .padding(5)
                    .background(.main)
                    .cornerRadius(12)
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
    }
    
}
