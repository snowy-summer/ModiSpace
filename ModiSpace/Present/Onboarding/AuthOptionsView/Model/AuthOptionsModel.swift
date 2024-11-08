//
//  AuthOptionsModel.swift
//  ModiSpace
//
//  Created by 전준영 on 11/6/24.
//

import Foundation
import Combine

@MainActor
final class AuthOptionsModel: ObservableObject {
    
    @Published var isLoggedIn: Bool = false
    @Published var showProfileSetup: Bool = false
    @Published var showAddressSetup: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private var kakaoAuthVM = KakaoAuthVM()
    private var appleAuthManager = AppleAuthManager()
    
    func apply(_ intent: AuthOptionsIntent) {
        switch intent {
        case .appleLogin:
            Task {
                self.isLoggedIn = await appleAuthManager.handleAppleSignIn()
            }
        case .kakaoLogin:
            Task { @MainActor in
                self.isLoggedIn = await kakaoAuthVM.loginWithKakao()
                self.showProfileSetup = kakaoAuthVM.showProfileSetup
                self.showAddressSetup = kakaoAuthVM.showAddressSetup
            }
        case .localLogin:
            print("app11")
        }
    }
    
}
