//
//  BasicLargeButtonCell.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct BasicLargeButtonCell: View {
    
    var title: String
    var isEnabled: Bool = true
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            if isEnabled {
                action()
            }
        }) {
            Text(title)
                .customFont(.title2)
                .frame(maxWidth: .infinity)
                .padding()
                .background(isEnabled ? Color.green : Color.gray)
                .foregroundStyle(.white)
                .cornerRadius(8)
        }
        .disabled(!isEnabled)
        
    }
}

