//
//  AuthOptionsView.swift
//  ModiSpace
//
//  Created by 전준영 on 10/27/24.
//

import SwiftUI

struct AuthOptionsView: View {
    
    var body: some View {
        VStack(spacing: 15) {
            Spacer().frame(height: 20)
            
            createAuthButton(
                icon: Image(systemName: "applelogo"),
                backgroundColor: .black,
                text: "Apple로 계속하기",
                textColor: .white,
                symbolColor: .white
            ) {
                // 애플 로그인 가능한지 여부 로직으로 시작
            }
            
            createAuthButton(
                icon: Image(systemName: "message.fill"),
                backgroundColor: .yellow,
                text: "카카오톡으로 계속하기",
                textColor: .black,
                symbolColor: .black
            ) {
                // 카카오 웹뷰 혹은 앱으로 갈지 선택으로 시작
            }
            
            createAuthButton(
                icon: Image(systemName: "envelope"),
                backgroundColor: .main,
                text: "이메일로 계속하기",
                textColor: .white,
                symbolColor: .white
            ) {
                // 로그인 화면으로 이동
            }
            
            HStack(spacing: 0) {
                Text("또는 ")
                    .font(.footnote)
                    .foregroundStyle(.black)
                
                Button(action: {
                    //회원가입 화면 넘기기
                }) {
                    Text("새롭게 회원가입 하기")
                        .font(.footnote)
                        .foregroundStyle(.main)
                }
            }
            .padding(.top, 10)
            
            Spacer()
        }
        .padding(.horizontal, 40)
        .padding(.top, 20)
        .presentationDetents([.fraction(0.35), .fraction(0.5)]) // ios 16 이상부터 씀
        //앞에는 처음 올라오는 위치, 뒤는 내가 최대로 올릴 수 있는 위치
    }
    
    // 공통 버튼 생성 함수 (나중에 로직 정해지면 변경 예정)
    private func createAuthButton(icon: Image, backgroundColor: Color,text: String,
                                  textColor: Color,symbolColor: Color,
                                  action: @escaping () -> Void) -> some View {
        
        Button(action: action) {
            CustomButton(
                icon: icon,
                backgroundColor: backgroundColor,
                text: text,
                textColor: textColor,
                symbolColor: symbolColor,
                cornerRadius: 12
            )
        }
        
    }
    
}

#Preview {
    AuthOptionsView()
}
