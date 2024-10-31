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

//MARK: - NetworkManagerProtocol
extension NetworkManager: NetworkManagerProtocol {
    
    func getData(from router: RouterProtocol) async throws -> Data {
        
        let (data, response) = try await session.getData(from: router)
        
        do {
            try validateResponse(response)
        } catch {
            handleErrorData(data: data)
        }
        
        return data
    }
    
    
    func getDecodedData(from router: RouterProtocol) async throws -> Decodable {
        
        let (data, response) = try await session.getData(from: router)
        
        do {
            try validateResponse(response)
        } catch {
            handleErrorData(data: data)
        }
        
        guard let type = router.responseType else { return EmptyResponseDTO() }
        
        do {
            let decodedData = try decoder.decode(type, from: data)
            return decodedData
        } catch {
            print(NetworkError.decodingFailed("\(type)"))
            throw NetworkError.decodingFailed("\(type)")
        }
    }
    
}

//MARK: - 유효성, Error핸들링
extension NetworkManager {
    
    private func validateResponse(_ response: URLResponse) throws {
        
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { throw NetworkError.invalidResponse }
        
        guard (200..<300) ~= statusCode else {
            print("StatusCode: \(statusCode)")
            throw NetworkError.invalidResponse
        }
        
    }
    
    private func handleErrorData(data: Data) {
        
        do {
            let errorData = try decoder.decode(ErrorDTO.self, from: data)
            print(APIError(errorCode: errorData.errorCode).description)
        } catch {
            print(NetworkError.decodingFailed("ErrorDTO"))
        }
        
    }
    
}
