//
//  SendChannelRequestBody.swift
//  ModiSpace
//
//  Created by 전준영 on 10/31/24.
//

import Foundation

struct SendChannelRequestBody: Encodable {
    
    let content: String
    let files: [Data]
    
}
