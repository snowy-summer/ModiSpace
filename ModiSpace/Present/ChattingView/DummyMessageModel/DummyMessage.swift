//
//  DummyMessage.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct DummyMessage: Identifiable {
    
    let id = UUID()
    let text: String
    let isCurrentUser: Bool
    let profileImage: String
    let images: [String]?
    
}

