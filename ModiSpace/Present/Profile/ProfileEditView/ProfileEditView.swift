//
//  ProfileEditView.swift
//  ModiSpace
//
//  Created by 전준영 on 11/12/24.
//

import SwiftUI

struct ProfileEditView: View {
    
    @ObservedObject var model: ProfileModel
    @Environment(\.dismiss) var dismiss
    
    let isEditingNickname: Bool
    
    init(model: @autoclosure @escaping @MainActor () -> ProfileModel,
         isEditingNickname: Bool) {
        _model = ObservedObject(wrappedValue: model())
        self.isEditingNickname = isEditingNickname
    }
    
    var body: some View {
        VStack() {
            InputField(text: isEditingNickname ? $model.nickname : $model.phoneNumber,
                       title: nil,
                       placeholder: isEditingNickname ? "닉네임을 입력하세요" : "전화번호를 입력하세요.")
            
            Spacer()
            
            CommonButton(icon: nil,
                         backgroundColor: .main,
                         text: "완료",
                         textColor: .white,
                         symbolColor: nil,
                         cornerRadius: 12,
                         isEnabled: true) {
                if isEditingNickname {
                    model.apply(.nickname(model.nickname, isEditingNickname))
                } else {
                    model.apply(.phone(model.phoneNumber, isEditingNickname))
                }
            }
        }
        .padding()
        .navigationTitle(isEditingNickname ? "닉네임" : "연락처")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            dismiss()
        }) {
            Image(systemName: "chevron.left")
                .foregroundColor(.black)
        })
        .onChange(of: model.isUpdateSuccess) { success in
            if success {
                dismiss()
                model.isUpdateSuccess = false
            }
        }
    }
    
}
