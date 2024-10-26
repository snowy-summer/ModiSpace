//
//  InviteMemberView.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct InviteMemberView: View {
    
    @State private var email: String = ""
    
    var body: some View {
        VStack(spacing: 25) {
            
            InputFieldCell(text: $email, title: "이메일", placeholder: "초대하려는 팀원의 이메일을 입력하세요.")
            
            Spacer()
            
            BasicLargeButtonCell(title: "초대 보내기", isEnabled: isCreateButtonEnabled()) {
              //  print("입력한 이메일 \(email)")
            }
            .padding(.horizontal)
        }
        .padding(.top, 30)
        .background(Color.gray.opacity(0.2))
        .onTapGesture {
            self.endTextEditing()
        }
    }
    
    private func isCreateButtonEnabled() -> Bool {
        return !email.isEmpty
    }
}

#Preview {
    InviteMemberView()
}

