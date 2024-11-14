//
//  ContentView.swift
//  ModiSpace
//
//  Created by 최승범 on 10/24/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    var body: some View {
        WorkspaceView()
            .task {
                do {
                    //이메일 검증
                    //                    let validateEmail = try await NetworkManager().getData(from: UserRouter.validateEmail(body: CheckEmailRequestBody(email: "Modispace@naver.com")))
                    
                    
                    // 회원가입
//                                        let join = try await NetworkManager()
//                                            .getDecodedData(from: UserRouter.join(body: JoinRequestBody(email: "Modispace111@naver.com",
//                                                                                                        password: "A!2a0000",
//                                                                                                        nickname: "Modispace",
//                                                                                                        phone: "010-9999-9999",     deviceToken: "test_mac_Modi111")), type: UserDTO.self)
                    //
                    
                    URLCache.shared.removeAllCachedResponses()
                    //로그인
                    let router = UserRouter.login(body: LoginRequestBody(email: "Modispace@naver.com",
                                                                         password: "A!2a0000",
                                                                         deviceToken: "test_mac_Modi"))
                    
                    
                    let loginData = try await NetworkManager().getDecodedData(from: router, type: UserDTO.self)
                    
                    // 토큰 저장
                    KeychainManager.save(loginData.token.accessToken,
                                         forKey: .accessToken)
                    KeychainManager.save(loginData.token.refreshToken!,
                                         forKey: .refreshToken)
                    print("에세스토큰: \(loginData.token.accessToken)")
                    print("리프레쉬토큰: \(loginData.token.refreshToken)")
                } catch(let error) {
                    print(error.localizedDescription)
                }
            }
    }
}

#Preview {
   ContentView()
}
