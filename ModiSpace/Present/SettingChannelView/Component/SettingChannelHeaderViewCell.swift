//
//  SettingChannelHeaderViewCell.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct SettingChannelHeaderViewCell: View {
    var body: some View {
        VStack (spacing: 10){
            HStack{
                Text("#")
                Text("채널 이름")
                Spacer()
            }.font(.headline)
            Text("안녕하세요 새싹 여러분? 심심하셨죠? 이 채널은 나머지 모든 것을 위한 채널이에요. 팀원이 농담하거나 순간적인 아이디어를 공유하는 곳이죠 마음껐 즐기시던가 말던가")
        }
        
    }
}

#Preview {
    SettingChannelHeaderViewCell()
}

