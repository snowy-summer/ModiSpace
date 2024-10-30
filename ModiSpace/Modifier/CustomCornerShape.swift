//
//  CustomCornerShape.swift
//  ModiSpace
//
//  Created by 최승범 on 10/27/24.
//

import SwiftUI

struct CustomCornerShape: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

/*
 사용방법
 원하는 코너를 선택해서 변형이 가능
 .clipShape(CustomCornerShape(radius: 12, corners: [.bottomLeft, .bottomRight]))
 .dada(12 .bottom)
 */


