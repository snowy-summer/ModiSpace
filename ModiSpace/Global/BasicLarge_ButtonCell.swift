//
//  BasicLarge_ButtonCell.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct BasicLarge_ButtonCell: View {
    
    var title: String
    var isEnabled: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            if isEnabled {
                action()
            }
        }) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding()
                .background(isEnabled ? Color.green : Color.gray)
                .foregroundStyle(.white)
                .cornerRadius(8)
        }
        .disabled(!isEnabled)
        
    }
}

