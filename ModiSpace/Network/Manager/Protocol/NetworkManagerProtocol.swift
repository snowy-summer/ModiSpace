//
//  NetworkManagerProtocol.swift
//  ModiSpace
//
//  Created by 최승범 on 10/26/24.
//

import Foundation

protocol NetworkManagerProtocol {
    
    func getData(from router: RouterProtocol) async throws -> Data
    
}
