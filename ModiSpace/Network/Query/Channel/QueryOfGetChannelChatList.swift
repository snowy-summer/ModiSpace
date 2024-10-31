//
//  QueryOfGetChannelChatList.swift
//  ModiSpace
//
//  Created by 전준영 on 10/31/24.
//

import Foundation

struct QueryOfGetChannelChatList: QueryStringProtocol {
    
    private let cursorDate: String
    
    init(cursorDate: String) {
        self.cursorDate = cursorDate
    }
    
    func asQueryItems() -> [URLQueryItem] {
        return [URLQueryItem(name: "cursor_date", value: cursorDate)]
    }
    
}
