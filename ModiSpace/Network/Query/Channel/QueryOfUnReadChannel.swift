//
//  QueryOfUnReadChannel.swift
//  ModiSpace
//
//  Created by 전준영 on 10/31/24.
//

import Foundation

struct QueryOfUnReadChannel: QueryStringProtocol {
    
    private let after: String
    
    init(after: String) {
        self.after = after
    }
    
    func asQueryItems() -> [URLQueryItem] {
        return [URLQueryItem(name: "after",
                             value: after)]
    }
    
}
