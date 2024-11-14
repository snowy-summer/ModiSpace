//
//  AppleAuthManager.swift
//  ModiSpace
//
//  Created by 전준영 on 11/8/24.
//

import AuthenticationServices
import Combine

final class AppleAuthManager: NSObject, ObservableObject {
    
    private let networkManager = NetworkManager()
    private var cancellables = Set<AnyCancellable>()
    
    func handleAppleSignIn() async -> Bool {
        return await withCheckedContinuation { [weak self] continuation in
            let request = ASAuthorizationAppleIDProvider().createRequest()
            request.requestedScopes = [.fullName, .email]
            
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
            self?.continuation = continuation
        }
    }
    
    private var continuation: CheckedContinuation<Bool, Never>?
}

extension AppleAuthManager: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let identityTokenData = appleIDCredential.identityToken,
              let identityToken = String(data: identityTokenData, encoding: .utf8) else {
            print("Apple Sign-In Failed: Unable to extract identity token")
            continuation?.resume(returning: false)
            return
        }
        
        let fullName = appleIDCredential.fullName
        let nickname = (fullName?.familyName ?? "하") + (fullName?.givenName ?? "루")
        //"하루"로 기본 닉네임 설정 했습니다. 애플로그인때 닉네임 가리기 선택 해버리면 네트워크 오류나서
        
        print("Success, Token: \(identityToken), Name: \(nickname)")
        
        let deviceToken = KeychainManager.load(forKey: .deviceToken) ?? ""
        let requestBody = AppleLoginRequestBody(idToken: identityToken,
                                                nickname: nickname,
                                                deviceToken: deviceToken)
        
        networkManager.getDecodedDataWithPublisher(from: UserRouter.loginApple(body: requestBody),
                                                   type: UserDTO.self)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case .failure(let error) = completion {
                        print("Apple Login Network Error: \(error.localizedDescription)")
                        self?.continuation?.resume(returning: false)
                    }
                },
                receiveValue: { [weak self] response in
                    print("Response: \(response)")
                    let accessToken = response.token.accessToken
                    KeychainManager.save(accessToken,
                                         forKey: .accessToken)
                    
                    if let refreshToken = response.token.refreshToken {
                        KeychainManager.save(refreshToken,
                                             forKey: .refreshToken)
                    }
                    
                    KeychainManager.save(response.userID,
                                         forKey: .userID)
                    
                    self?.continuation?.resume(returning: true)
                }
            )
            .store(in: &cancellables)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple Sign-In Failed: \(error.localizedDescription)")
        continuation?.resume(returning: false)
    }
}

extension AppleAuthManager: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIApplication.shared.windows.first { $0.isKeyWindow } ?? UIWindow()
    }
}
