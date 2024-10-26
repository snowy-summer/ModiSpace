//
//  SettingChannel_Home.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct SettingChannel_Home: View {
    var body: some View {
        
        SettingChannelHeaderViewCell()
        
        MemberList()
        
        SettingChannelButtonCell(title: "채널 편집") { }
        SettingChannelButtonCell(title: "채널에서 나가기") { }
        SettingChannelButtonCell(title: "채널 관리자 변경") { }
        
        SettingChannelButtonCell(title: "채널 삭제") { }
    }
}

#Preview {
    SettingChannel_Home()
}

