//
//  PlusButtonCell.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct PlusButtonCell: View {
    
    var text: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "plus")
                Text(text)
                    .customFont(.body)
                Spacer()
            }
            .foregroundStyle(.textSecondary)
        }
        
    }
}
