//
//  AddMemberView.swift
//  ModiSpace
//
//  Created by 최승범 on 11/6/24.
//

import SwiftUI

struct AddMemberView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var model: AddMemberModel = AddMemberModel()
    
    var body: some View {
        VStack(spacing: 24) {
            InputField(text: $model.email,
                           title: "이메일",
                           placeholder: "초대 받을 사람의 이메일을 입력해주세요 (필수)")
            
            
            Spacer()
            
            CommonButton(icon: nil,
                         backgroundColor: .main,
                         text: "초대",
                         textColor: .white,
                         symbolColor: nil,
                         cornerRadius: 8,
                         isEnabled: model.isAble) {
                model.apply(.addMember)
                dismiss()
            }
            .padding(.horizontal)
        }
        .padding(.top, 32)
        .onTapGesture {
            endTextEditing()
        }
    }
    
}
