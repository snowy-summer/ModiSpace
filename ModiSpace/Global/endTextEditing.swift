//
//  endTextEditing.swift
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
    
}

/*
 키보드 내리는 함수 입니다.
사용법: 원하는 뷰의 백그라운드 밑에 코드를 붙이면 키보드가 내려갑니다.
    .onTapGesture {
        self.endTextEditing()
}
 */

