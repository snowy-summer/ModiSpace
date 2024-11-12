//
//  SignInViewModel.swift
//  ModiSpace
//
//  Created by 최승범 on 11/12/24.
//

import Foundation
import Combine

final class SignInViewModel: ObservableObject {
    
    @Published var loginEmail: String = ""
    @Published var loginPassword: String = ""
    @Published var showWorkspace: Bool = false
    
    var isloginButtonEnabled: Bool {
        return !loginEmail.isEmpty && !loginPassword.isEmpty
    }
    
    private let networkManager = NetworkManager()
    private var cancelable = Set<AnyCancellable>()
    
    func apply(_ intent: SignInViewIntent) {
        switch intent {
        case .login:
            login()
            
        case .loginFail:
            print("로그인 실패")
        }
    }

}

extension SignInViewModel {
    
    func login() {
        guard let token = KeychainManager.load(forKey: KeychainKey.deviceToken.rawValue) else { return }
        let router = UserRouter.login(body: LoginRequestBody(email: loginEmail,
                                                             password: loginPassword,
                                                             deviceToken: token))
        networkManager.getDecodedDataWithPublisher(from: router,
                                                   type: UserDTO.self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    // 추가 에러 핸들링 필요
                    self?.apply(.loginFail)
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] loginData in
                KeychainManager.save(loginData.token.accessToken,
                                     forKey: KeychainKey.accessToken.rawValue)
                KeychainManager.save(loginData.token.refreshToken!,
                                     forKey: KeychainKey.refreshToken.rawValue)
                self?.showWorkspace = true
            }.store(in: &cancelable)
        
    }
    
}
