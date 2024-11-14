//
//  ChannelSection.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/29/24.
//

import SwiftUI

struct ChannelSection: View {
    
    @EnvironmentObject var workspaceModel: WorkspaceModel
    @ObservedObject var model: CategoryListModel
    
    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    model.apply(.changingShowedChannelState)
                }
            }) {
                HStack {
                    Text("채널")
                        .font(.headline)
                        .foregroundStyle(Color.black)
                    Spacer()
                    
                    Image(systemName: "chevron.forward")
                        .foregroundStyle(Color.black)
                        .rotationEffect(.degrees(model.isShowChannels ? 90 : 0))
                        .animation(.easeInOut(duration: 0.3), value: model.isShowChannels)
                }
                .padding()
            }
            
            if model.isShowChannels {
                VStack(alignment: .leading) {
                    ForEach(workspaceModel.selectedWorkspaceChannelList, id: \.channelID) { channel in
                        NavigationLink(
                            //🌟
                            destination: ChattingView(channel: channel),
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
            }
        }
        .sheet(item: $model.sheetType,
               onDismiss: {
            workspaceModel.apply(.reloadChannelList)
        }) { type in
            WorkspaceSheetView(type: type)
                .presentationDragIndicator(.visible)
        }
    }
    
}
