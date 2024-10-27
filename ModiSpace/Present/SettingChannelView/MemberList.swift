//
//  MemberList.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct MemberList: View {
    
    @State private var isMemberListShow = false
    
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
                    Text("(\(memberCount))")
                    Spacer()
                    Image(systemName: isMemberListShow ? "chevron.down" : "chevron.forward")
                        .foregroundStyle(.black)
                }
                .padding()
            }
            
            if isMemberListShow {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(0..<memberCount, id: \.self) { _ in
                        //MemberCell()
                        ProfileNickView(profile: "", nickText: "dfdf")
                    }
                }
                .padding(.horizontal, 10)
            }
        }
        
    }
}

#Preview {
    SettingChannel_Home()
}

