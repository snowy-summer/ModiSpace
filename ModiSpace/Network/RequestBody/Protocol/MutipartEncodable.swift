//
//  MutipartEncodable.swift
//  ModiSpace
//
//  Created by 최승범 on 10/31/24.
//

import Foundation

protocol MutipartEncodable: Encodable {
    
    func toMultipartFormData() -> [MultipartFormData]
    
}
