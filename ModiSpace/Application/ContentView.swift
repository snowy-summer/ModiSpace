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
        CreateWorkspaceView()
            .task {
                do {
                    //이메일 검증
//                    let validateEmail = try await NetworkManager().getData(from: UserRouter.validateEmail(body: CheckEmailRequestBody(email: "Modispace@naver.com")))
                    
                    
                    // 회원가입
//                    let join = try await NetworkManager()
//                        .getDecodedData(from: UserRouter.join(body: JoinRequestBody(email: "Modispace@naver.com",
//                                                                                    password: "A!2a0000",
//                                                                                    nickname: "Modispace",
//                                                                                    phone: "010-9999-9999",     deviceToken: "test_mac_Modi")))
//                    
                    //로그인
                    let login = try await NetworkManager()
                        .getDecodedData(from: UserRouter.login(body: LoginRequestBody(email: "Modispace@naver.com",
                                                                                      password: "A!2a0000",
                                                                                      deviceToken: "test_mac_Modi")))
                    print(login)
                } catch(let error) {
                    print(error.localizedDescription)
                }
            }
    }
}

#Preview {
    ContentView()
}
