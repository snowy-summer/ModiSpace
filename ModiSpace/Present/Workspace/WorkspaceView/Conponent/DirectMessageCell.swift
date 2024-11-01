//
//  DirectMessageCell.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct DirectMessageCell: View {
    
    var directTitle: String
    var icon: String
    var badge: String? = "n개"
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .resizable()
                .background(.main)
                .customRoundedRadius()
            
            Text(directTitle)
                .font(.system(size: 16))
               
            Spacer()
            
            if let badge = badge {
                Text(badge)
                    .font(.system(size: 12))
                    .foregroundStyle(.white)
                    .padding(4)
                    .background(.main)
                    .cornerRadius(12)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
    }
    
}

