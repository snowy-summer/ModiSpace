//
//  MemberList.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct MemberList: View {
    
    @State private var isMemberListShow = false
    
    @StateObject var model: ChatModel
    
    let memberCount = 30

    // Grid 설정: 4열로 설정
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            Button(action: {
                isMemberListShow.toggle()
            }) {
                HStack {
                    Text("멤버")
                    Text(" \(model.channelMembers.count)")
                    Spacer()
                    Image(systemName: isMemberListShow ? "chevron.down" : "chevron.forward")
                        .foregroundStyle(.black)
                }
                .padding()
            }
            
            if isMemberListShow {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(model.channelMembers, id: \.userID) { member in
                        ProfileNickCell(profile: member.profileImage ?? "",
                                        nickText: member.nickname)
                    }
                }
                .padding(.horizontal, 12)
            }
        }.onAppear {
            model.apply(.getChannelMembers)
        }
    }
    
}
