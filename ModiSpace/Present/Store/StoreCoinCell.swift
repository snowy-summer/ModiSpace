//
//  StoreCoinCell.swift
//  ModiSpace
//
//  Created by 최승범 on 10/25/24.
//

import SwiftUI

struct StoreCoinCell: View {
    
    let titleText: String
    let realMoneyText: String
    var action: () -> Void
    
    var body: some View {
        HStack {
            Text(titleText)
                .customFont(.bodyBold)
            
            Spacer()
            
            Button (action: {
                action()
            }) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.main)
                    .overlay {
                        Text(realMoneyText)
                            .customFont(.title2)
                            .foregroundStyle(.white)
                    }
            }
            .frame(width: 72, height: 40)
            
        }
        .frame(maxWidth: .infinity)
    }
    
}
