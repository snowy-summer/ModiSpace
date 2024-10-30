//
//  PayvalidationRequestBody.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/30/24.
//

import Foundation

struct PayvalidationRequestBody: Encodable {
    
    let impuid: String
    let merchantuid: String
    
    enum CodingKeys: String, CodingKey {
        case impuid = "imp_uid"
        case merchantuid = "merchant_uid"
    }
    
}
