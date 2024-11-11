//
//  HeaderView.swift
//  ModiSpace
//
//  Created by 전준영 on 11/11/24.
//

import SwiftUI

struct HeaderView: View {
    
    let coverImage: UIImage
    let name: String
    let action: () -> Void

    var body: some View {
        HStack {
            Image(uiImage: coverImage)
                .resizable()
                .customRoundedRadius()
            
            Text(name)
                .font(.system(size: 20, weight: .bold))
            
            Spacer()
            
            Button(action: action) {
                Image(systemName: "star")
                    .resizable()
                    .background(Color.main)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.black, lineWidth: 3)
                    )
            }
        }
        .padding()
    }
    
}
