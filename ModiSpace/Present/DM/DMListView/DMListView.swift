//
//  DMListView.swift
//  ModiSpace
//
//  Created by 전준영 on 11/10/24.
//

import SwiftUI

struct DMListView: View {
    
    @StateObject var model = DMListModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                HeaderView(
                    coverImage: UIImage(resource: .temp),
                    name: "Direct Message",
                    profileImage: UIImage(resource: .temp),
                    action: {
                        
                    }
                )
                
                VStack(spacing: 0) {
                    Divider()
                        .background(.gray)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(model.workspaceMemberList, id: \.userID) { member in
                                Button(action: {
                                    model.apply(.creatRoom(opponentID: member.userID))
                                }) {
                                    ProfileNickCell(
                                        profile: member.profileImage ?? "tempImage",
                                        nickText: member.nickname
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    .padding(.vertical, 12)
                    
                    Divider()
                        .background(.gray)
                }
                
                List {
                    ForEach(model.dmsList, id: \.roomID) { dm in
                        let unreadCount = model.unReadCount.first(where: { $0.roomID == dm.roomID })?.count ?? 0
                        
                        NavigationLink(destination: DMChattingView(dm: dm)) {
                            DMListCell(
                                profileImage: dm.user.profileImage ?? "tempImage",
                                userNickname: dm.user.nickname,
                                message: "메시지 호출 하나 더 해야함..",
                                time: dm.createdAt,
                                badgeCount: unreadCount
                            )
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        
        NavigationLink(
            destination: DMChattingView(dm: model.createMember),
            isActive: $model.isShowChattingView
        ) {
            EmptyView()
        }
        
        .onAppear() {
            model.apply(.viewAppear)
        }
        .onChange(of: model.isExpiredRefreshToken) {
            setRootView(what: OnboardingView())
        }
    }
    
}
