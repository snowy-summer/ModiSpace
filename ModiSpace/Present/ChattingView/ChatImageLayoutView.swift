//
//  ChatImageLayoutView.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/28/24.
//

import SwiftUI

struct ChatImageLayoutView: View {
    let images: [UIImage]? 

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Chat message text")
                .padding(.bottom, 5)

        
            if let images = images, !images.isEmpty {
                if images.count == 1 {
         
                    Image(uiImage: images[0])
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width * 0.8, height: 200)
                        .clipped()
                    
                } else if images.count == 2 {
                 
                    HStack(spacing: 5) {
                        ForEach(images, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: (UIScreen.main.bounds.width * 0.8 - 5) / 2, height: 150)
                                .clipped()
                        }
                    }
                    
                } else if images.count == 3 {
              
                    VStack(spacing: 5) {
                        Image(uiImage: images[0])
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width * 0.8, height: 150)
                            .clipped()

                        HStack(spacing: 5) {
                            ForEach(images[1...2], id: \.self) { image in
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: (UIScreen.main.bounds.width * 0.8 - 5) / 2, height: 150)
                                    .clipped()
                            }
                        }
                    }
                } else {
                    // 이미지가 4개 이상 일때
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 5) {
                        ForEach(images, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: (UIScreen.main.bounds.width * 0.8 - 5) / 2, height: 150)
                                .clipped()
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}
