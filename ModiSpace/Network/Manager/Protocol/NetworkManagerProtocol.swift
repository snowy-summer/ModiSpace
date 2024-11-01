//
//  NetworkManagerProtocol.swift
//  ModiSpace
//
//  Created by 최승범 on 10/26/24.
//

import Foundation
import Combine

protocol NetworkManagerProtocol {
    
    func getData(from router: RouterProtocol) async throws -> Data
    func getDecodedData<T:Decodable>(from router: RouterProtocol,
                                     type: T.Type) async throws -> T 
    func getData(from router: RouterProtocol) -> AnyPublisher<Data, Error>
    func getDecodedData<T: Decodable>(from router: RouterProtocol,
                                      type: T.Type) -> AnyPublisher<T, Error>
    
}
