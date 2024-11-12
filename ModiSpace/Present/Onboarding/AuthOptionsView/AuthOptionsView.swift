//
//  AuthOptionsView.swift
//  ModiSpace
//
//  Created by 전준영 on 10/27/24.
//

import SwiftUI

struct AuthOptionsView: View {
    
    @StateObject private var model = AuthOptionsModel()
    
    @State private var showSignUpView = false
    @State private var showWorkspaceView = false
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer().frame(height: 20)
            
            CommonButton(
                icon: Image(systemName: "applelogo"),
                backgroundColor: .black,
                text: "Apple로 계속하기",
                textColor: .white,
                symbolColor: .white,
                cornerRadius: 12
            ) {
                model.apply(.appleLogin)
            }
            
            CommonButton(
                icon: Image(systemName: "message.fill"),
                backgroundColor: .yellow,
                text: "카카오톡으로 계속하기",
                textColor: .black,
                symbolColor: .black,
                cornerRadius: 12
            ) {
                model.apply(.kakaoLogin)
            }
            
            CommonButton(
                icon: Image(systemName: "envelope"),
                backgroundColor: .main,
                text: "이메일로 계속하기",
                textColor: .white,
                symbolColor: .white,
                cornerRadius: 12
            ) {
                model.apply(.showSignInView)
            }
            
            HStack(spacing: 0) {
                Text("또는 ")
                    .font(.footnote)
                    .foregroundStyle(.black)
                
                Button(action: {
                    model.apply(.showSignUpView)
                }) {
                    Text("새롭게 회원가입 하기")
                        .font(.footnote)
                        .foregroundStyle(.main)
                }
            }
            .padding(.top, 8)
            
            Spacer()
            
        }
        .padding(.horizontal, 40)
        .padding(.top, 20)
        .presentationDetents([.fraction(0.35), .fraction(0.5)]) // ios 16 이상부터 씀
        //앞에는 처음 올라오는 위치, 뒤는 내가 최대로 올릴 수 있는 위치
        .sheet(item: $model.sheetType) { type in
            AuthSheetView(type: type)
                .presentationDragIndicator(.visible)
        }
        .onReceive(model.$isLoggedIn) { isLoggedIn in
            if isLoggedIn {
                setRootViewToWorkspace()
            }
        }
    }
    
    private func setRootViewToWorkspace() {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        let rootViewController = UIHostingController(rootView: WorkspaceView())
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
    
}

#Preview {
    AuthOptionsView()
}
