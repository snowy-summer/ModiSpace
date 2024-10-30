//
//  PayvalidationDTO.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/30/24.
//

import Foundation

struct PayvalidationDTO: Decodable {
    
    let billingid: String
    let merchantuid: String
    let buyerid: String
    let productName: String
    let price: Int
    let sesacCoin: Int
    let paidAt: String
    
    enum CodingKeys: String, CodingKey {
        case billingid = "billing_id"
        case merchantuid = "merchant_uid"
        case buyerid = "buyer_id"
        case productName, price, sesacCoin, paidAt
    }
    
}

