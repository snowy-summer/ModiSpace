//
//  QueryOfUnReadDMS.swift
//  ModiSpace
//
//  Created by 전준영 on 11/1/24.
//

import Foundation

struct QueryOfUnReadDMS: QueryStringProtocol {
    
    private let after: String
    
    init(after: String) {
        self.after = after
    }
    
    func asQueryItems() -> [URLQueryItem] {
        return [URLQueryItem(name: "after",
                             value: after)]
    }
    
}
