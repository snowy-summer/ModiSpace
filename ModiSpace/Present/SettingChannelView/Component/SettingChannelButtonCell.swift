//
//  SettingChannelButtonCell.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct SettingChannelButtonCell: View {
    
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .foregroundStyle(.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 1)
                )
        }
        .padding(.horizontal)
        
    }
}



#Preview{
    SettingChannelButtonCell(title: "채널에서 나가기") {
        print("Button tapped")
    }
}
