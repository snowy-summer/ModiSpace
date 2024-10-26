//
//  DirectListCell.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct DirectListCell: View {
    
    var directTitle: String
    var icon: String
    var badge: String? = "n개"
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .resizable()
                .background(Color.green)
                .frame(width: 44, height: 44)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.trailing,8)
            
            Text(directTitle)
                .font(.system(size: 16))
               
            Spacer()
            
            if let badge = badge {
                Text(badge)
                    .font(.system(size: 12))
                    .foregroundStyle(.white)
                    .padding(5)
                    .background(Color.green)
                    .cornerRadius(12)
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
        
    }
}

