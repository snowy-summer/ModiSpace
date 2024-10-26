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
    
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {
    
}
