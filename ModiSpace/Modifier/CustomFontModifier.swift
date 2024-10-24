//
//  CustomFontModifier.swift
//  ModiSpace
//
//  Created by 최승범 on 10/24/24.
//

import SwiftUI

struct CustomFontModifier: ViewModifier {
    
    let fontType: FontType

    func body(content: Content) -> some View {
        content
            .font(Font(fontType.font))
    }
    
}

extension View {
    
    func customFont(_ fontType: FontType) -> some View {
        self.modifier(CustomFontModifier(fontType: fontType))
    }
    
}
