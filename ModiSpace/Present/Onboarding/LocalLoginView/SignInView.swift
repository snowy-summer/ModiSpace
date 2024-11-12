//
//  SignInView.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct SignInView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var model = SignInViewModel()
    
    var body: some View {
        VStack(spacing: 24) {
            InputField(text: $model.loginEmail,
                       title: "이메일",
                       placeholder: "이메일을 입력하세요")
            
            InputField(text: $model.loginPassword,
                       title: "비밀번호",
                       placeholder: "비밀번호를 입력하세요")
            
            Spacer()
            
            CommonButton(icon: nil,
                         backgroundColor: .main,
                         text: "로그인",
                         textColor: .white,
                         symbolColor: nil,
                         cornerRadius: 8,
                         isEnabled: model.isloginButtonEnabled) {
                
            }
                         .padding(.horizontal)
        }
        .navigationTitle("이메일 로그인")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.top, 32)
        .background(.gray.opacity(0.2))
        .onTapGesture {
            endTextEditing()
        }
    }
    
}

#Preview {
    SignInView()
}




