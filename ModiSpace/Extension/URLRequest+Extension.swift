//
//  URLRequest+Extension.swift
//  ModiSpace
//
//  Created by 최승범 on 10/26/24.
//

import Foundation

extension URLRequest {
    
    init(url: URL, method: HTTPMethod, headers: [String: String] = [:]) throws {
        self.init(url: url)
        
        httpMethod = method.rawValue
        allHTTPHeaderFields = headers
    }
    
}
