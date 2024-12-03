//
//  CacheManager.swift
//  ModiSpace
//
//  Created by 최승범 on 11/2/24.
//

import Foundation
import SwiftUI

final class ImageCacheManager {
    
    static let shared = ImageCacheManager()
    private init() {}
    
    private let nsCache = NSCache<NSString, NSData>()
    private let urlCache = URLCache(memoryCapacity: 50 * 1024 * 1024, // 50 MB
                                    diskCapacity: 100 * 1024 * 1024, // 100 MB
                                    diskPath: "imageCache")
    
    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = urlCache
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        return URLSession(configuration: configuration)
    }()
   
    func fetchImage(from router: RouterProtocol) async -> UIImage? {
        guard let url = router.url?.absoluteString else { return nil }
        let cacheKey = NSString(string: url)
        
        if let cachedData = nsCache.object(forKey: cacheKey),
           let image = UIImage(data: cachedData as Data) {
            return image
        }
        
        let request = try? RequestBuilder().setRouter(router).build()
        if let request = request,
           let cachedResponse = urlCache.cachedResponse(for: request),
           let cachedImage = UIImage(data: cachedResponse.data) {
            return cachedImage
        }
        
        do {
            let (data1, response) = try await session.data(for: request!)
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { throw NetworkError.invalidResponse }
            
            guard (200..<300) ~= statusCode else {
                print("StatusCode: \(statusCode)")
                let errorData = try JSONDecoder().decode(ErrorDTO.self, from: data1)
                let error = APIError(errorCode: errorData.errorCode)
                print(error.description)
                throw NetworkError.invalidResponse
            }
            
            let cachedResponse = CachedURLResponse(response: response, data: data1)
            
            urlCache.storeCachedResponse(cachedResponse, for: request!)
            
            nsCache.setObject(NSData(data: data1), forKey: cacheKey)
            
            return UIImage(data: data1)
        } catch {
            return nil
        }
    }
    
}
