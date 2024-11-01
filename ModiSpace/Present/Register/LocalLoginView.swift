//
//  LocalLoginView.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct LocalLoginView: View {
    
    @State private var loginEmail: String = ""
    @State private var loginPassword: String = ""
    
    var onCreate: () -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            InputFieldCell(text: $loginEmail,
                           title: "이메일",
                           placeholder: "이메일을 입력하세요")
            
            InputFieldCell(text: $loginPassword,
                           title: "비밀번호",
                           placeholder: "비밀번호를 입력하세요")
            
            Spacer()
            
            CommonButton(icon: nil,
                         backgroundColor: .main,
                         text: "로그인",
                         textColor: .white,
                         symbolColor: nil,
                         cornerRadius: 8,
                         isEnabled: isCreateButtonEnabled()) {
                onCreate()
            }
            .padding(.horizontal)
            .disabled(!isCreateButtonEnabled())
        }
        .padding(.top, 32)
        .background(.gray.opacity(0.2))
        .onTapGesture {
            endTextEditing()
        }
    }
    
}

extension LocalLoginView {
    
    private func isCreateButtonEnabled() -> Bool {
        return !loginEmail.isEmpty && !loginPassword.isEmpty
    }
    
}


#Preview {
    LocalLoginView(onCreate: {
        print("로그인 버튼 실행")
    })
}


