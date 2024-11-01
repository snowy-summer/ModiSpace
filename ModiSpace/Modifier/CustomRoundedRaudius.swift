//
//  CustomRoundedRaudius.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/31/24.
//

import SwiftUI

struct RoundedRadius: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(width: 44, height: 44)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.trailing, 8)
    }
    
}

extension View {
    
    func customRoundedRadius() -> some View {
        self.modifier(RoundedRadius())
    }
    
}

