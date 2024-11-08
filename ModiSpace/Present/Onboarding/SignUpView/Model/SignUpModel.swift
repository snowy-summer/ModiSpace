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
    
    @Published var isEmailEditable = true
    @Published var isSignUpSuccessful = false
    @Published var emailErrorMessage: String? = nil
    @Published var passwordErrorMessage: String? = nil
    
    private let networkManager = NetworkManager()
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
            fetchValidateEmail()
            
        case .signUp:
            signUp()
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
        isSignUpEnabled = isEmailValid && isNicknameValid && isPhoneNumberValid && isPasswordValid && isPasswordMatch && !isEmailEditable
    }
    
    private func fetchValidateEmail() {
        let requestBody = CheckEmailRequestBody(email: email)
        
        networkManager.getDataWithPublisher(from: UserRouter.validateEmail(body: requestBody))
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                print("이메일 유효성 검사 성공")
            case .failure(let error):
                if let networkError = error as? NetworkError {
                    self.emailErrorMessage = networkError.description
                    self.isEmailValid = false
                    self.isEmailEditable = true
                    print("Error: \(networkError.description)")
                }
            }
        }, receiveValue: { _ in
            self.isEmailValid = true
            self.isEmailEditable = false
            self.emailErrorMessage = nil
            print("이메일 중복 없음")
        })
        .store(in: &cancellables)
    }
    
    private func signUp() {
        guard password == confirmPassword else {
            passwordErrorMessage = "비밀번호가 일치하지 않습니다. 다시 확인해 주세요."
            return
        }
        let deviceToken = KeychainManager.load(forKey: KeychainKey.deviceToken.rawValue) ?? ""
        
        let signUpRequest = JoinRequestBody(email: email,
                                            password: password,
                                            nickname: nickname,
                                            phone: phoneNumber,
                                            deviceToken: deviceToken)
        
        networkManager.getDecodedDataWithPublisher(from: UserRouter.join(body: signUpRequest),
                                                   type: UserDTO.self)
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                print("success")
            case .failure(let error):
                if let networkError = error as? NetworkError {
                    print("Error: \(networkError.description)")
                }
            }
        }, receiveValue: { response in
            let accessToken = response.token.accessToken
            KeychainManager.save(accessToken,
                                 forKey: KeychainKey.accessToken.rawValue)
            
            if let refreshToken = response.token.refreshToken {
                KeychainManager.save(refreshToken,
                                     forKey: KeychainKey.refreshToken.rawValue)
            }
            
            KeychainManager.save(response.userID,
                                 forKey: KeychainKey.userID.rawValue)
            print("회원가입: \(response)")
            self.isSignUpSuccessful = true
        })
        .store(in: &cancellables)
    }
    
}
