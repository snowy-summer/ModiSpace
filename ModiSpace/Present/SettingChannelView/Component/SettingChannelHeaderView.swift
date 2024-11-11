//
//  SettingChannelHeaderView.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct SettingChannelHeaderView: View {
    
    @StateObject var model: ChatModel
    
    var body: some View {
        VStack (spacing: 10){
            HStack{
                Text("#")
                
                Text(model.channel.name)
                
                Spacer()
            }.font(.headline)
            
            Text(model.channel.description ?? "채널 설정 정보 없음")
        }
    }
    
}

//#Preview {
//    SettingChannelHeaderView()
//}

