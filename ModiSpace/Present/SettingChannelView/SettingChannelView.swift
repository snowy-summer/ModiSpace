//
//  SettingChannelView.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct SettingChannelView: View {
    
    @StateObject var model: ChatModel
    
    var body: some View {
        SettingChannelHeaderView(model: model)
        
        MemberList()
        
        SettingChannelButton(title: "채널 편집") { }
        
        SettingChannelButton(title: "채널에서 나가기") { }
        
        SettingChannelButton(title: "채널 관리자 변경") { }
        
        SettingChannelButton(title: "채널 삭제") { }
    }
    
}

//#Preview {
//    SettingChannelView()
//}

