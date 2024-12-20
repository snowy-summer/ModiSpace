//
//  URLSessionProtocol.swift
//  ModiSpace
//
//  Created by 최승범 on 10/26/24.
//

import Foundation

protocol URLSessionProtocol {
    
    func getData(from router: RouterProtocol) async throws -> (Data, URLResponse)
    func webSocket(from router: RouterProtocol) throws -> URLSessionWebSocketTask
    
}

protocol URLSessionDataTaskProtocol {
    
    func resume()
    
}
