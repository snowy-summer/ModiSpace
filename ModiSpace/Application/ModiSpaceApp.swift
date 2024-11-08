//
//  ModiSpaceApp.swift
//  ModiSpace
//
//  Created by 최승범 on 10/24/24.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
// 스플래시 화면 보기 없애고 싶을때 이걸로
//@main
//struct ModiSpaceApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}

@main
struct ModiSpaceApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State var isSplashView = true
    
    init() {
        let nativeAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] ?? ""
        KakaoSDK.initSDK(appKey: nativeAppKey as! String)
    }
    
    var body: some Scene {
        
        WindowGroup {
            
            if isSplashView {
                LaunchScreenView()
                    .ignoresSafeArea()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) { // 1초로 설정
                            isSplashView = false
                        }
                    }
            } else {

                OnboardingView()
                    .onOpenURL { url in
                        if (AuthApi.isKakaoTalkLoginUrl(url)) {
                            _ = AuthController.handleOpenUrl(url: url)
                        }
                    }

            }
            
        }
        
    }
}

struct LaunchScreenView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = UIStoryboard(name: "Launch Screen", bundle: nil).instantiateInitialViewController()!
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
}
