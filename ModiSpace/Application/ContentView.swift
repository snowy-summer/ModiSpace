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
                    // 토큰 저장
                    if let userInfo = login as? UserDTO {
                        KeychainManager.save(userInfo.token.accessToken,
                                             forKey: KeychainKey.accessToken.rawValue)
                        KeychainManager.save(userInfo.token.refreshToken!,
                                             forKey: KeychainKey.refreshToken.rawValue)
                        print(userInfo.token.accessToken)
                    }
                    
                    
                    // 워크스페이스 조회
//                    let myWorkspaceList = try await NetworkManager()
//                        .getDecodedData(from: WorkSpaceRouter.getWorkSpaceList)
//                    
//                    //워크스페이스 생성
//                    let createWorkspace = try await NetworkManager()
//                        .getDecodedData(from: WorkSpaceRouter.createWorkSpace(body: WorkspaceRequestBody(name: "test_1_ModiSpace",
//                                                                                                         description: "테스트",
//                                                                                                         image: UIImage(resource: .temp).jpegData(compressionQuality: 0.4) ?? Data())))
//                    
//                    print(createWorkspace)
                    
                } catch(let error) {
                    print(error.localizedDescription)
                }
            }
    }
}

#Preview {
    ContentView()
}
