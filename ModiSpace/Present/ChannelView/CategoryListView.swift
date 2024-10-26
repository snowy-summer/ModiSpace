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
                ChannelActionSheetCell(
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
                            destination: ChattingView_Home(chatTitle: title),
                            label: {
                                ChannelListCell(channelTitle: title)
                                    .foregroundStyle(Color.gray)
                            }
                        )
                    }
                    PlusButtonCell(text: "채널 추가") {
                        showActionSheet = true
                    }
                }
                .transition(.slide)
            }
        }
        
    }
}

struct DirectMessageSection: View {
    
    @Binding var isDirectShow: Bool
    @Binding var showNewMessageView: Bool
    
    let directMessages: [String]
    
    var body: some View {
        VStack {
            Button(action: {
                isDirectShow.toggle()
            }) {
                HStack {
                    Text("다이렉트 메시지")
                        .font(.headline)
                        .foregroundStyle(Color.black)
                    Spacer()
                    Image(systemName: isDirectShow ? "chevron.down" : "chevron.forward")
                        .foregroundStyle(Color.black)
                }
                .padding()
            }
            
            if isDirectShow {
                VStack(alignment: .leading) {
                    ForEach(directMessages, id: \.self) { name in
                        NavigationLink(
                            destination: ChattingView_Home(chatTitle: name),
                            label: {
                                DirectListCell(directTitle: name, icon: "star")
                                    .foregroundStyle(Color.gray)
                            }
                        )
                    }
                    PlusButtonCell(text: "새 메시지 시작") {
                        showNewMessageView = true
                    }
                }
                .transition(.slide)
            }
        }
        
    }
}

#Preview {
    ChannelView_Home()
}

