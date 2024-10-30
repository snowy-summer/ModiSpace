//
//  PayvalidationDTO.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/30/24.
//

import Foundation

struct PayvalidationDTO: Decodable {
    
    let billing_id: String
    let merchant_uid: String
    let buyer_id: String
    let productName: String
    let price: Int
    let sesacCoin: Int
    let paidAt: String
    
}
