//
//  ModiSpaceApp.swift
//  ModiSpace
//
//  Created by 최승범 on 10/24/24.
//

import SwiftUI

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
                ContentView()
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
