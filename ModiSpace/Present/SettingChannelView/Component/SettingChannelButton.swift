//
//  SettingChannelButton.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct SettingChannelButton: View {
    
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.white)
                .foregroundStyle(.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.black, lineWidth: 1)
                )
        }
        .padding(.horizontal)
    }
    
}

#Preview{
    SettingChannelButton(title: "채널에서 나가기") {
        print("Button tapped")
    }
}
