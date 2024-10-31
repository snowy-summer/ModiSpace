//
//  OwnershipTransferDTO.swift
//  ModiSpace
//
//  Created by 전준영 on 10/31/24.
//

import Foundation

struct OwnershipTransferDTO: Decodable {
    
    let ownerID: String
    
    enum CodingKeys: String, CodingKey {
        case ownerID = "ownerID"
    }
    
}
