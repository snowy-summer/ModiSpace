//
//  AsyncImageVIew.swift
//  ModiSpace
//
//  Created by 최승범 on 11/2/24.
//

import SwiftUI

struct AsyncImageView: View {
    
    @State private var uiImage: UIImage? = nil
    private let placeholder: Image
    private let router: RouterProtocol
    
    init(path: String,
         placeholder: Image = Image(systemName: "photo")) {
        self.router = ImageRouter.getImage(path: path)
        self.placeholder = placeholder
    }
    
    var body: some View {
        Group {
            if let uiImage = uiImage {
                Image(uiImage: uiImage)
                    .resizable()
            } else {
                placeholder
                    .resizable()
                    .onAppear {
                        loadImage()
                    }
            }
        }
    }
    
    private func loadImage() {
        Task {
            if let fetchedImage = await ImageCacheManager.shared.fetchImage(from: router) {
                DispatchQueue.main.async {
                    uiImage = fetchedImage
                }
            }
        }
    }
    
}
