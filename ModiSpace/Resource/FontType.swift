//
//  FontType.swift
//  ModiSpace
//
//  Created by 최승범 on 10/24/24.
//

import SwiftUI

enum FontType {
    
    case title1
    case title2
    case bodyBold
    case body
    case caption
    
    var font: UIFont {
        switch self {
        case .title1:
            return .systemFont(ofSize: 22, weight: .bold)
        case .title2:
            return .systemFont(ofSize: 14, weight: .bold)
        case .bodyBold:
            return .systemFont(ofSize: 13, weight: .bold)
        case .body:
            return .systemFont(ofSize: 13, weight: .regular)
        case .caption:
            return .systemFont(ofSize: 12, weight: .regular)
        }
    }
    
}
