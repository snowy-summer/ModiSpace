//
//  ChannelSection.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/29/24.
//

import SwiftUI

struct ChannelSection: View {
    
    @ObservedObject var model: CategoryListModel
    
    var body: some View {
        VStack {
            Button(action: {
                model.apply(.changingShowedChannelState)
            }) {
                HStack {
                    Text("채널")
                        .font(.headline)
                        .foregroundStyle(Color.black)
                    Spacer()
                    Image(systemName: model.isShowChannels ? "chevron.down" : "chevron.forward")
                        .foregroundStyle(Color.black)
                }
                .padding()
            }
            
            if model.isShowChannels {
                VStack(alignment: .leading) {
                    ForEach(model.channelList, id: \.channelID) { channel in
                        NavigationLink(
                            destination: ChattingView(chatTitle: channel.name),
                            label: {
                                ChannelListCell(channelTitle: channel.name)
                                    .foregroundStyle(Color.gray)
                            }
                        )
                    }
                    
                    SFSubButton(text: "채널 추가") {
                        model.apply(.showActionSheet)
                    }
                    .padding()
                }
                .transition(.slide)
            }
        }
    }
    
}
