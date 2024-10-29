//
//  ChannelSection.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/29/24.
//

import SwiftUI

struct ChannelSection: View {
    
    @Binding var isChannelsShow: Bool
    @Binding var showActionSheet: Bool
    @Binding var channelTitles: [String]
    
    var body: some View {
        VStack {
            Button(action: {
                isChannelsShow.toggle()
            }) {
                HStack {
                    Text("채널")
                        .font(.headline)
                        .foregroundStyle(Color.black)
                    Spacer()
                    Image(systemName: isChannelsShow ? "chevron.down" : "chevron.forward")
                        .foregroundStyle(Color.black)
                }
                .padding()
            }
            
            if isChannelsShow {
                VStack(alignment: .leading) {
                    ForEach(channelTitles, id: \.self) { title in
                        NavigationLink(
                            destination: ChattingView(chatTitle: title),
                            label: {
                                ChannelListCell(channelTitle: title)
                                    .foregroundStyle(Color.gray)
                            }
                        )
                    }
                    
                    SFSubButton(text: "채널 추가") {
                        showActionSheet = true
                    }
                    .padding()
                }
                .transition(.slide)
            }
        }
    }
    
}
