//
//  NetworkManager.swift
//  ModiSpace
//
//  Created by 최승범 on 10/26/24.
//

import Foundation
import Combine

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
    
    
    func getDecodedData<T:Decodable>(from router: RouterProtocol,
                                     type: T.Type) async throws -> T {
        
        let (data, response) = try await session.getData(from: router)
        
        do {
            try validateResponse(response)
        } catch {
            handleErrorData(data: data)
        }
        
        do {
            let decodedData = try decoder.decode(type, from: data)
            return decodedData
        } catch {
            print(NetworkError.decodingFailed("\(type)"))
            throw NetworkError.decodingFailed("\(type)")
        }
    }
    
    func getData(from router: RouterProtocol) -> AnyPublisher<Data, Error> {
        Future { promise in
            Task { [weak self] in
                guard let self = self else { return }
                
                let (data, response): (Data, URLResponse)
                
                do {
                    (data, response) = try await self.session.getData(from: router)
                    try validateResponse(response)
                    promise(.success(data))
                } catch {
                    handleErrorData(data: data)
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func getDecodedData<T: Decodable>(from router: RouterProtocol,
                                      type: T.Type) -> AnyPublisher<T, Error> {
        Future { promise in
            Task { [weak self] in
                guard let self = self else { return }
                
                let (data, response): (Data, URLResponse)
                do {
                    (data, response) = try await self.session.getData(from: router)
                    try validateResponse(response)
                    
                    let decodedData = try self.decoder.decode(type, from: data)
                    promise(.success(decodedData))
                } catch {
                    self.handleErrorData(data: data)
                    promise(.failure(NetworkError.decodingFailed("\(type)")))
                }
            }
        }
        .eraseToAnyPublisher()
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
