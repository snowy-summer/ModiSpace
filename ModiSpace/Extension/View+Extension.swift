//
//  View+Extension.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

extension View {
    
    func endTextEditing() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    /*
     키보드 내리는 함수 입니다.
     사용법: 원하는 뷰의 백그라운드 밑에 코드를 붙이면 키보드가 내려갑니다.
     .onTapGesture {
     endTextEditing()
     }
     */
    
    func customCornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        self.clipShape(CustomCornerShape(radius: radius, corners: corners))
    }
    /*
     사용방법
     원하는 코너를 선택해서 변형이 가능
     .customCornerRadius(12, corners: [.bottomLeft, .bottomRight])
     .dada(12 .bottom)
     */
    
    func dragGesture(direction: DragDirection,
                     action: @escaping () -> Void) -> some View {
        self.gesture(
            DragGesture()
                .onChanged { value in
                    
                    switch direction {
                    case .left:
                        if value.translation.width < 0 {
                            withAnimation {
                                action()
                            }
                        }
                        
                    case .right:
                        if value.translation.width > 0 {
                            withAnimation {
                                action()
                            }
                        }
                        
                    case .both:
                        withAnimation {
                            action()
                        }
                    }
                }
        )
    }
    
    /*
     사용방법
     방향 선택후 액션
     .dragGesture(direction: .left) {
     action()
     }
     */
    
    func setRootView(what view: some View) {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        let rootViewController = UIHostingController(rootView: view)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
    
}

enum DragDirection {
    
    case left
    case right
    case both
    
}
