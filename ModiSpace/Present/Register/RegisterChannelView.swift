//
//  RegisterChannelView.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct RegisterChannelView: View {
    
    @Binding var newChannelTitle: String
    
    @State private var channelName: String = ""
    @State private var channelDescription: String = ""
    
    var onCreate: () -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            
            InputField(text: $channelName,
                           title: "채널 이름",
                           placeholder: "채널 이름을 입력하세요 (필수)")
            
            InputField(text: $channelDescription,
                           title: "채널 설명",
                           placeholder: "채널을 설명하세요 (옵션)")
            
            Spacer()
            
            BasicLargeButtonCell(title: "생성",
                                 isEnabled: isCreateButtonEnabled()) {
                           newChannelTitle = channelName
                           onCreate()
                       }
                       .padding(.horizontal)
        }
        .padding(.top, 32)
        .background(.gray.opacity(0.2))
        .onTapGesture {
            endTextEditing()
        }
    }
    
}

extension RegisterChannelView {
    
    func isCreateButtonEnabled() -> Bool {
        return !channelName.isEmpty
    }
    
}
