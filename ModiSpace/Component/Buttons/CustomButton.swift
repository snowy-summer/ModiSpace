//
//  CustomButton.swift
//  ModiSpace
//
//  Created by 전준영 on 10/26/24.
//

import SwiftUI

struct CustomButton: View {
    
    let icon: Image? //글자만 있는 버튼도 사용할 수 있도록
    let backgroundColor: Color //배경
    let text: String //글자
    let textColor: Color //글자색상
    let symbolColor: Color? //로고 색상
    let cornerRadius: CGFloat //모서리
    
    var body: some View {
        HStack {
            
            if let icon = icon {
                icon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundStyle(symbolColor ?? .primary)
            }
            
            Text(text)
                .font(.headline)
                .foregroundStyle(textColor.opacity(0.85))
            
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .cornerRadius(cornerRadius)
    }
    
}

struct CustomLoginButton_Previews: PreviewProvider {
    
    static var previews: some View {
        
        VStack(spacing: 10) {
            
            CustomButton(
                icon: Image(systemName: "applelogo"),
                backgroundColor: .black,
                text: "Apple로 계속하기",
                textColor: .white,
                symbolColor: .white,
                cornerRadius: 12
            )
            
            
            CustomButton(
                icon: Image(systemName: "message.fill"),
                backgroundColor: .yellow,
                text: "카카오톡으로 계속하기",
                textColor: .black,
                symbolColor: .black,
                cornerRadius: 12 // 카카오에서 12로 하라고 하네요
            )
            
            CustomButton(
                icon: Image(systemName: "envelope"),
                backgroundColor: Color.green,
                text: "이메일로 계속하기",
                textColor: .white,
                symbolColor: .white,
                cornerRadius: 12
            )
        }
        .padding()
        
    }
    
}
