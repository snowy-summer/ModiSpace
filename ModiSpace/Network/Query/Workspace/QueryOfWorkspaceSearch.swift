//
//  QueryOfWorkspaceSearch.swift
//  ModiSpace
//
//  Created by 최승범 on 10/26/24.
//

import Foundation

struct QueryOfWorkspaceSearch: QueryStringProtocol {
    
    private let keyword: String
    
    init(keyword: String) {
        self.keyword = keyword
    }
    
    func asQueryItems() -> [URLQueryItem] {
        return [URLQueryItem(name: "keyword", value: keyword)]
    }
    
}
