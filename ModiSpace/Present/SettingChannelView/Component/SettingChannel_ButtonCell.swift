//
//  SettingChannel_ButtonCell.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct SettingChannel_ButtonCell: View {
    
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
    SettingChannel_ButtonCell(title: "채널에서 나가기") {
        print("Button tapped")
    }
}
