//
//  RequestBuilder.swift
//  ModiSpace
//
//  Created by 최승범 on 10/25/24.
//

import Foundation

final class RequestBuilder {
    
    private var url: URL?
    private var method: HTTPMethod = .get
    private var headers: [String: String] = [:]
    private var body: Data?

    func setRouter(_ router: RouterProtocol) -> RequestBuilder {
        
        url = router.url
        method = router.method
        headers = router.headers
        body = router.body
        
        return self
    }
    
    func setURL(_ url: URL) -> RequestBuilder {
        self.url = url
        return self
    }

    func setHeaders(_ headers: [String: String]) -> RequestBuilder {
        
        headers.forEach { self.headers[$0.key] = $0.value }
        return self
    }

    func setBody(_ body: Data?) -> RequestBuilder {
        
        self.body = body
        return self
    }

    func build() throws -> URLRequest {
        
        guard let url = url else { throw NetworkError.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        
        return request
    }
    
}
