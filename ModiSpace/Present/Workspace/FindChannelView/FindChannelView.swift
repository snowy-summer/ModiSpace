//
//  FindChannelView.swift
//  ModiSpace
//
//  Created by 최승범 on 11/8/24.
//

import SwiftUI

struct FindChannelView: View {
    
    @StateObject var model: FindChannelModel = FindChannelModel()
    
    var body: some View {
        
        VStack(alignment: .leading) {
            ForEach(model.channelList, id: \.channelID) { channel in
                NavigationLink(
                    destination: ChattingView(channel: channel),
                    label: {
                        ChannelListCell(channelTitle: channel.name)
                            .foregroundStyle(Color.gray)
                            .listRowSeparator(.hidden)
                    }
                )
            }
            
            Spacer()
        }
        .listStyle(.plain)
        .onAppear() {
            model.apply(.fetchChannelList)
        }
    }
    
}
