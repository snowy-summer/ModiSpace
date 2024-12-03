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
                        model.isShowProfileView = true
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
                        let lastMessage = model.dmsLastMessage.first(where: { $0.roomID == dm.roomID })?.content ?? "마지막 내용이 없습니다"
                        let time = model.dmsLastMessage.first(where: { $0.roomID == dm.roomID })?.createdAt
                        let formattedTime = time != nil ? DateManager().relativeFormattedTime(from: time!) : "시간 없음"
                        
                        NavigationLink(destination: DMChattingView(dms: dm)) {
                            DMListCell(
                                profileImage: dm.user.profileImage ?? "tempImage",
                                userNickname: dm.user.nickname,
                                message: lastMessage,
                                time: formattedTime,
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
            destination: DMChattingView(dms: model.createMember),
            isActive: $model.isShowChattingView
        ) {
            EmptyView()
        }
        NavigationLink(destination: ProfileView(),
                       isActive: $model.isShowProfileView) {
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
