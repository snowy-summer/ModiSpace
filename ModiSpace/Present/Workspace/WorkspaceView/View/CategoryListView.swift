//
//  CategoryListView.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct CategoryListView: View {
    
    @EnvironmentObject var workspaceModel: WorkspaceModel
    @StateObject private var model: CategoryListModel = CategoryListModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                ChannelSection(model: model)
                
                Divider()
//                
//                DirectMessageSection(isDirectShow: $isDirectShow,
//                                     showNewMessageView: $showNewMessageView, directMessages: directMessages)
            }
            
            Divider()
            
            .overlay(
                ChannelActionSheet(
                    isPresented: $model.showActionSheet,
                    actions: [
                        .default(Text("채널 생성")) {
                            model.apply(.showAddChannelView)
                        },
                        .default(Text("채널 탐색")) {
                            model.apply(.showFindChannelView)
                        },
                        .cancel(Text("취소"))
                    ]
                )
            )
        }
    }
    
}

#Preview {
    WorkspaceView()
}
