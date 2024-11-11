//
//  ImageSelectButton.swift
//  ModiSpace
//
//  Created by 최승범 on 10/27/24.
//

import SwiftUI

struct ImageSelectButton: View {
    
    var action: () -> Void
    var image: UIImage?
    
    var body: some View {
        
        Button(action: action) {
            Image(uiImage: image ?? UIImage(resource: .temp))
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    ZStack {
                        Circle()
                            .fill(.white)
                            .frame(width: 40,
                                   height: 40)
                            .offset(x: 10,
                                    y: 10)
                        
                        Image(systemName: "camera.circle.fill")
                            .resizable()
                            .frame(width: 32,
                                   height: 32)
                            .foregroundColor(.main)
                            .background(.white)
                            .clipShape(Circle())
                            .offset(x: 10,
                                    y: 10)
                    },
                    alignment: .bottomTrailing
                )
        }
    }
    
}
