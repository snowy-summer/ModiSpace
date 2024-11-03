//
//  CreateDMSRequestBody.swift
//  ModiSpace
//
//  Created by 전준영 on 11/1/24.
//

import Foundation

struct CreateDMSRequestBody: Encodable {
    
    let opponentID: String
    
    enum CodingKeys: String, CodingKey {
        case opponentID = "opponent_id"
    }
    
}
