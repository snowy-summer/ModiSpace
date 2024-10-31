//
//  OwnershipTransferRequestBody.swift
//  ModiSpace
//
//  Created by 전준영 on 10/31/24.
//

import Foundation

struct OwnershipTransferRequestBody: Encodable {
    
    let ownerID: String
    
    enum CodingKeys: String, CodingKey {
        case ownerID = "owner_id"
    }
    
}
