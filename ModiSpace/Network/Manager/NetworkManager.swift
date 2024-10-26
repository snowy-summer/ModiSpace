//
//  NetworkManager.swift
//  ModiSpace
//
//  Created by 최승범 on 10/26/24.
//

import Foundation

final class NetworkManager {
    
    private let session: URLSessionProtocol
    private let decoder = JSONDecoder()
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
}

extension NetworkManager: NetworkManagerProtocol {
    
    private func validateResponse(_ response: URLResponse) throws {
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { throw NetworkError.invalidResponse }
        guard (200..<300) ~= statusCode else {
            print(statusCode)
            throw NetworkError.invalidResponse
        }
    }
    
    func getData(from router: RouterProtocol) async throws -> Data {
        
        let (data, response) = try await session.getData(from: router)
        
        try validateResponse(response)
        
        return data
    }
    
    func getDecodedData(from router: RouterProtocol) async throws -> Decodable {
        
        let (data, response) = try await session.getData(from: router)
        
        try validateResponse(response)
        
        let decodedData = try decoder.decode(router.responseType, from: data)
        return decodedData
    }
    
}
