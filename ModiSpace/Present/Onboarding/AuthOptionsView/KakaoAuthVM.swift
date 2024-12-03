//
//  KakaoAuthVM.swift
//  ModiSpace
//
//  Created by 전준영 on 11/5/24.
//

import SwiftUI
import Combine
import KakaoSDKAuth
import KakaoSDKUser

@MainActor
final class KakaoAuthVM: ObservableObject{
    
    @Published var isLoggedIn : Bool = false
    @Published var showProfileSetup: Bool = false
    @Published var showAddressSetup: Bool = false
    
    private let networkManager = NetworkManager()
    private var cancellables = Set<AnyCancellable>()
    var fetchedKakaoData: UserDTO?
    
    //MARK: - 카카오톡 앱으로 로그인 인증
    func loginWithKakao() async -> Bool {
        let isLoggedIn = UserApi.isKakaoTalkLoginAvailable()
        ? await loginUsingApp()
        : await loginUsingAccount()
        
        if isLoggedIn {
            await handlePostLogin()
        }
        
        return isLoggedIn
    }
    
    private func loginUsingApp() async -> Bool {
        await withCheckedContinuation { continuation in
            UserApi.shared.loginWithKakaoTalk { [weak self] oauthToken, error in
                self?.handleLoginResult(oauthToken: oauthToken,
                                        error: error,
                                        continuation: continuation)
            }
        }
    }
    
    private func loginUsingAccount() async -> Bool {
        await withCheckedContinuation { continuation in
            UserApi.shared.loginWithKakaoAccount { [weak self] oauthToken, error in
                self?.handleLoginResult(oauthToken: oauthToken,
                                        error: error,
                                        continuation: continuation)
            }
        }
    }
    
    private func handleLoginResult(oauthToken: OAuthToken?,
                                   error: Error?,
                                   continuation: CheckedContinuation<Bool, Never>) {
        if let error = error {
            print(error)
            continuation.resume(returning: false)
            return
        }
        
        guard let accessToken = oauthToken?.accessToken else {
            print("OAuthToken or access token not found")
            continuation.resume(returning: false)
            return
        }
        
        let deviceToken = KeychainManager.load(forKey: .deviceToken) ?? ""
        let requestBody = KakaoLoginRequestBody(oauthToken: accessToken,
                                                deviceToken: deviceToken)
        
        networkManager.getDecodedDataWithPublisher(from: UserRouter.loginKakao(body: requestBody),
                                                   type: UserDTO.self)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion, let networkError = error as? NetworkError {
                        print("Error: \(networkError.description)")
                    }
                },
                receiveValue: { [weak self] response in
                    print("카카오로그인: \(response)")
                    self?.fetchedKakaoData = response
                    
                    let accessToken = response.token.accessToken
                    KeychainManager.save(accessToken,
                                         forKey: .accessToken)
                    
                    if let refreshToken = response.token.refreshToken {
                        KeychainManager.save(refreshToken,
                                             forKey: .refreshToken)
                    }
                    
                    KeychainManager.save(response.userID,
                                         forKey: .userID)
                    
                    continuation.resume(returning: true)
                }
            )
            .store(in: &cancellables)
        
    }
    
    private func handlePostLogin() async {
        if parseExistsUserFromResponse() {
            showAddressSetup = true
        } else {
            showProfileSetup = true
        }
    }

    private func parseExistsUserFromResponse() -> Bool {
        return fetchedKakaoData != nil
    }
    
    //MARK: -로그아웃
    @available(*, renamed: "kakaoLogout()")
    func kakaoLogout(completion: @escaping () -> Void){
        Task{
            if await handleKakaoLogout(){
                self.isLoggedIn = false
            }
        }
        
        completion()
    }
    
    func kakaoLogout() async {
        return await withCheckedContinuation { continuation in
            kakaoLogout() {
                continuation.resume(returning: ())
            }
        }
    }
    
    
    private func handleKakaoLogout() async -> Bool{
        await withCheckedContinuation{ continuation in
            UserApi.shared.logout {(error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("logout() success.")
                    continuation.resume(returning: true)
                }
            }
            
        }
    }
    
}
