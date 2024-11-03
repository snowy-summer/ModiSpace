//
//  SignUpModel.swift
//  ModiSpace
//
//  Created by 전준영 on 11/3/24.
//

import Foundation
import Combine

final class SignUpModel: ObservableObject {
    
    @Published var email = ""
    @Published var nickname = ""
    @Published var phoneNumber = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    @Published var isEmailValid = false
    @Published var isNicknameValid = false
    @Published var isPhoneNumberValid = false
    @Published var isPasswordValid = false
    @Published var isPasswordMatch = false
    
    @Published var isSignUpEnabled = false
    @Published var isCheckEmailEnabled = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func apply(_ intent: SignUpIntent) {
        switch intent {
        case .validateEmail(let email):
            self.email = email
            self.isEmailValid = validateEmail(email)
            self.isCheckEmailEnabled = self.isEmailValid
            
        case .validateNickname(let nickname):
            self.nickname = nickname
            self.isNicknameValid = !nickname.isEmpty
            
        case .validatePhoneNumber(let phoneNumber):
            self.phoneNumber = phoneNumber
            self.isPhoneNumberValid = !phoneNumber.isEmpty
            
        case .validatePassword(let password):
            self.password = password
            self.isPasswordValid = password.count >= 8
            
        case .validateConfirmPassword(let confirmPassword):
            self.confirmPassword = confirmPassword
            self.isPasswordMatch = (confirmPassword == password)
            
        case .checkSignUpEnabled:
            checkSignUpEnabled()
            
        case .checkEmailDuplicate:
            print("이메일 중복 확인 실행")
        }
    }
    
}

extension SignUpModel {
    
    private func validateEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        
        return predicate.evaluate(with: email)
    }
    
    private func checkSignUpEnabled() {
        isSignUpEnabled = isEmailValid && isNicknameValid && isPhoneNumberValid && isPasswordValid && isPasswordMatch
    }
    
}
