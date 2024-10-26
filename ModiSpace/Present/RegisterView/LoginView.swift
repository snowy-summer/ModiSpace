//
//  LoginView.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct LoginView: View {
    
    @State private var loginEmail: String = ""
    @State private var loginPassword: String = ""
    
    var onCreate: () -> Void
    
    var body: some View {
        VStack(spacing: 25) {
            
            InputFieldCell(text: $loginEmail, title: "이메일", placeholder: "이메일을 입력하세요")
            InputFieldCell(text: $loginPassword, title: "비밀번호", placeholder: "비밀번호를 입력하세요")
            
            Spacer()
            
            BasicLargeButtonCell(title: "로그인", isEnabled: isCreateButtonEnabled()) {
                onCreate()
            }
            .padding(.horizontal)
            .disabled(!isCreateButtonEnabled())
        }
        .padding(.top, 30)
        .background(Color.gray.opacity(0.2))
        .onTapGesture {
            endTextEditing()
        }
        
    }
}

extension LoginView {
    
    private func isCreateButtonEnabled() -> Bool {
        return !loginEmail.isEmpty && !loginPassword.isEmpty
    }
    
}


#Preview {
    LoginView(onCreate: {
        print("로그인 버튼 실행")
    })
}


