//
//  TextFieldAttachImageScrollView.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/31/24.
//

import SwiftUI

struct TextFieldAttachImageScrollView: View {
    
    var images: [UIImage]
    var onRemoveImage: (Int) -> Void
    
    var body: some View {
        if !images.isEmpty {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(Array(images.enumerated()), id: \.offset) { index, image in
                        ZStack(alignment: .topTrailing) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                            Button(action: {
                                onRemoveImage(index)
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.white)
                                    .background(.black.opacity(0.7))
                                    .clipShape(Circle())
                            }
                            .offset(x: 5, y: -5)
                        }
                    }
                }
                .padding(.top, 4)
            }
        }
    }
    
}

