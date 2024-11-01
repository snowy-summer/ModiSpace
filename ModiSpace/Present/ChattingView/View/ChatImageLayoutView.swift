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
        VStack(alignment: .leading, spacing: 8) {
            if let images = images, !images.isEmpty {
                
                switch images.count {
                    
                case 1:
                    Image(uiImage: images[0])
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width * 0.8, height: 200)
                        .clipped()
                    
                case 2:
                    HStack(spacing: 4) {
                        ForEach(images, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: (UIScreen.main.bounds.width * 0.8 - 5) / 2, height: 150)
                                .clipped()
                        }
                    }
                    
                case 3:
                    VStack(spacing: 4) {
                        Image(uiImage: images[0])
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width * 0.8, height: 150)
                            .clipped()
                        
                        HStack(spacing: 4) {
                            ForEach(images[1...2], id: \.self) { image in
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: (UIScreen.main.bounds.width * 0.8 - 5) / 2, height: 150)
                                    .clipped()
                            }
                        }
                    }
                    
                case 4:
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 4) {
                        ForEach(images, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: (UIScreen.main.bounds.width * 0.8 - 5) / 2, height: 150)
                                .clipped()
                        }
                    }
                    
                case 5:
                    VStack(spacing: 4) {
                        Image(uiImage: images[0])
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width * 0.8, height: 150)
                            .clipped()
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 4) {
                            ForEach(images[1...4], id: \.self) { image in
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: (UIScreen.main.bounds.width * 0.8 - 5) / 2, height: 150)
                                    .clipped()
                            }
                        }
                    }
                    
                default:
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 4) {
                        ForEach(images.prefix(6), id: \.self) { image in
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
        .background(.gray.opacity(0.1))
        .cornerRadius(8)
    }
    
}

