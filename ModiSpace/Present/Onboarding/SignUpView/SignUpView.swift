//
//  SignUpView.swift
//  ModiSpace
//
//  Created by 전준영 on 11/2/24.
//

import SwiftUI

struct SignUpView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var model = SignUpModel()
    
    var body: some View {
        
        NavigationStack {
            VStack(spacing: 4) {
                HStack(spacing: 4){
                    InputField(text: $model.email,
                               title: "이메일",
                               placeholder: "이메일을 입력하세요",
                               keyboardType: .emailAddress,
                               isEditable: model.isEmailEditable)
                    .onChange(of: model.email) { email in
                        model.apply(.validateEmail(email))
                        model.apply(.checkSignUpEnabled)
                    }
                    
                    CommonButton(icon: nil,
                                 backgroundColor: .main,
                                 text: "중복 확인",
                                 textColor: .white,
                                 symbolColor: nil,
                                 cornerRadius: 8,
                                 isEnabled: model.isCheckEmailEnabled) {
                        model.apply(.checkEmailDuplicate)
                    }
                                 .frame(width: 100)
                                 .padding(.top, 40)
                                 .padding(.trailing)
                }
                
                
                InputField(text: $model.nickname,
                           title: "닉네임",
                           placeholder: "닉네임을 입력하세요",
                           keyboardType: .emailAddress)
                .onChange(of: model.nickname) { nickname in
                    model.apply(.validateNickname(nickname))
                    model.apply(.checkSignUpEnabled)
                }
                .padding(.top)
                .padding(.horizontal)
                
                InputField(text: $model.phoneNumber,
                           title: "연락처",
                           placeholder: "전화번호를 입력하세요",
                           keyboardType: .emailAddress)
                .onChange(of: model.phoneNumber) { phoneNumber in
                    model.apply(.validatePhoneNumber(phoneNumber))
                    model.apply(.checkSignUpEnabled)
                }
                .padding(.top)
                .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    InputField(text: $model.password,
                               title: "비밀번호",
                               placeholder: "비밀번호를 입력하세요",
                               keyboardType: .emailAddress,
                               isSecure: true)
                    .onChange(of: model.password) { password in
                        model.apply(.validatePassword(password))
                        model.apply(.checkSignUpEnabled)
                    }
                    .padding(.top)
                    .padding(.horizontal)
                    
                    Text("8자리 이상 적어주세요")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .padding(.leading, 40)
                }
                
                InputField(text: $model.confirmPassword,
                           title: "비밀번호 확인",
                           placeholder: "비밀번호를 한 번 더 입력하세요",
                           keyboardType: .emailAddress,
                           isSecure: true)
                .onChange(of: model.confirmPassword) { confirmPassword in
                    model.apply(.validateConfirmPassword(confirmPassword))
                    model.apply(.checkSignUpEnabled)
                }
                .padding(.top)
                .padding(.horizontal)
                
                Spacer()
                
                CommonButton(icon: nil,
                             backgroundColor: .main,
                             text: "가입하기",
                             textColor: .white,
                             symbolColor: nil,
                             cornerRadius: 8,
                             isEnabled: model.isSignUpEnabled) {
                    model.apply(.signUp)
                }
                             .padding()
                             .onReceive(model.$isSignUpSuccessful) { isSuccess in
                                 if isSuccess {
                                     setRootView(what: CustomTabView())
                                 }
                             }
            }
            .navigationTitle("회원가입")
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
        }
    }
}
