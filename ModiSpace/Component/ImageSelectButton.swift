//
//  ImageSelectButton.swift
//  ModiSpace
//
//  Created by 최승범 on 10/27/24.
//

import SwiftUI

struct ImageSelectButton: View {
    
    var tapGesture: () -> Void
    
    var body: some View {
        Image(uiImage: .temp)
            .resizable()
            .frame(width: 100, height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                ZStack {
                    
                    Circle()
                        .fill(.white)
                        .frame(width: 40, height: 40)
                        .offset(x: 10, y: 10)
                    
                    Image(systemName: "camera.circle.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.main)
                        .background(Color.white)
                        .clipShape(Circle())
                        .offset(x: 10, y: 10)
                },
                alignment: .bottomTrailing
            )
            .onTapGesture {
                tapGesture()
            }
    }
}

#Preview {
    ImageSelectButton(tapGesture: {})
}
