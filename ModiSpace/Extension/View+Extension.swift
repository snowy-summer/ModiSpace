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

}




