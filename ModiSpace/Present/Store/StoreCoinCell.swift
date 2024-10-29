//
//  StoreCoinCell.swift
//  ModiSpace
//
//  Created by 최승범 on 10/25/24.
//

import SwiftUI

struct StoreCoinCell: View {
    
    let titleText = "🎲 10 Coin"
    let realMoneyText = "₩ 100"
    
    var body: some View {
        HStack {
            
            Text(titleText)
                .customFont(.bodyBold)
            Spacer()
            Button {
                
            } label: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.main)
                    .overlay {
                        Text(realMoneyText)
                            .customFont(.title2)
                            .foregroundStyle(.white)
                    }
            }
            .frame(width: 72)
            
        }
        .frame(maxWidth: .infinity)
    }
    
}

#Preview {
    ContentView()
}
