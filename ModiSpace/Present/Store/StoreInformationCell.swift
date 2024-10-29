//
//  StoreInformationCell.swift
//  ModiSpace
//
//  Created by 최승범 on 10/25/24.
//

import SwiftUI

struct StoreInformationCell: View {
    
    let coinValue = 888
    
    var body: some View {
        HStack {
            
            Text("🎲 현재 보유한 코인")
                .customFont(.bodyBold)
            Text("\(coinValue)개")
                .customFont(.bodyBold)
                .foregroundStyle(.main)
            
            Spacer()
            
            Button {
                
            } label: {
               Text("코인이란?")
                    .customFont(.caption)
                    .foregroundStyle(.textSecondary)
            }
            .frame(width: 72)
            
        }
        .frame(maxWidth: .infinity)
    }
    
}


#Preview {
    StoreInformationCell()
}
