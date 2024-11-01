//
//  CommonButton.swift
//  ModiSpace
//
//  Created by 전준영 on 10/26/24.
//

import SwiftUI

struct CommonButton: View {
    
    let icon: Image? //글자만 있는 버튼도 사용할 수 있도록
    let backgroundColor: Color //배경색
    let disabledBackgroundColor: Color? = .gray// disabled일때 배경색상
    let text: String //글자
    let textColor: Color //글자색상
    let symbolColor: Color? //로고 색상
    let cornerRadius: CGFloat //모서리
    var isEnabled: Bool = true
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            if isEnabled {
                action()
            }
        }) {
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
            .background(isEnabled ? backgroundColor : (disabledBackgroundColor ?? backgroundColor))
            .cornerRadius(cornerRadius)
        }
        .disabled(!isEnabled)
    }
    
}

struct CustomLoginButton_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack(spacing: 12) {
            CommonButton(
                icon: Image(systemName: "applelogo"),
                backgroundColor: .black,
                text: "Apple로 계속하기",
                textColor: .white,
                symbolColor: .white,
                cornerRadius: 12
            ) {
                
            }
            
            CommonButton(
                icon: Image(systemName: "message.fill"),
                backgroundColor: .yellow,
                text: "카카오톡으로 계속하기",
                textColor: .black,
                symbolColor: .black,
                cornerRadius: 12 // 카카오에서 12로 하라고 하네요
            ){
                
            }
            
            CommonButton(
                icon: Image(systemName: "envelope"),
                backgroundColor: .main,
                text: "이메일로 계속하기",
                textColor: .white,
                symbolColor: .white,
                cornerRadius: 12
            ){
                
            }
        }
        .padding()
    }
    
}
