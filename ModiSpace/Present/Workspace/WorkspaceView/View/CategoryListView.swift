//
//  CategoryListView.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct CategoryListView: View {
    
    @StateObject private var model: CategoryListModel = CategoryListModel()
    
    let directMessages = ["캠퍼스지킴이", "Hue", "테스트 코드 짜는 새싹이", "Jack"]
    
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
                            print("채널 탐색 선택됨")
                        },
                        .cancel(Text("취소"))
                    ]
                )
            )
            .sheet(isPresented: $model.showAddChannelView) {
                RegisterChannelView() {
                    model.apply(.reloadChannelList)
                }
            }
        }
    }
    
}

#Preview {
    WorkspaceView()
}
