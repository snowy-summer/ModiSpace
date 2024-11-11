//
//  URLSession+Extension.swift
//  ModiSpace
//
//  Created by 최승범 on 10/26/24.
//

import Foundation

extension URLSession: URLSessionProtocol {
    
    func getData(from router: RouterProtocol) async throws -> (Data, URLResponse) {
        
        let request = try RequestBuilder()
            .setRouter(router)
            .build()
        return try await data(for: request)
    }
    
    func webSocket(from router: any RouterProtocol) throws -> URLSessionWebSocketTask {
        
        let request = try RequestBuilder()
            .setRouter(router)
            .build()
        
        return webSocketTask(with: request)
    }
    
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {
    
}
