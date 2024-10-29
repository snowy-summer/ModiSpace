//
//  CategoryListView.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct CategoryListView: View {
    
    @Binding var isChannelsShow: Bool
    @Binding var isDirectShow: Bool
    @Binding var showNewMessageView: Bool
    
    @State private var selectedDirect: String? = nil
    @State private var showActionSheet = false
    @State private var showAddChannelView = false
    @State private var newChannelTitle: String = ""
    @State private var channelTitles = ["일반", "스유 뽀개기", "앱스토어 홍보", "오픈라운지", "TIL"]
    
    let directMessages = ["캠퍼스지킴이", "Hue", "테스트 코드 짜는 새싹이", "Jack"]
    
    var body: some View {
        NavigationStack {
            VStack {
                ChannelSection(isChannelsShow: $isChannelsShow, showActionSheet: $showActionSheet, channelTitles: $channelTitles)
                
                Divider()
                
                DirectMessageSection(isDirectShow: $isDirectShow, showNewMessageView: $showNewMessageView, directMessages: directMessages)
            }
            
            Divider()
            
            .overlay(
                ChannelActionSheet(
                    isPresented: $showActionSheet,
                    actions: [
                        .default(Text("채널 생성")) {
                            showAddChannelView = true
                        },
                        .default(Text("채널 탐색")) {
                            print("채널 탐색 선택됨")
                        },
                        .cancel(Text("취소"))
                    ]
                )
            )
            .sheet(isPresented: $showAddChannelView) {
                RegisterChannelView(newChannelTitle: $newChannelTitle) {
                    if !newChannelTitle.isEmpty {
                        channelTitles.append(newChannelTitle)
                    }
                    showAddChannelView = false
                }
            }
        }
    }
    
}

#Preview {
    WorkspaceView()
}

