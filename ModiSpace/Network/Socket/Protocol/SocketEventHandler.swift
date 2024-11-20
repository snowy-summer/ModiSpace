//
//  SocketEventHandler.swift
//  ModiSpace
//
//  Created by 전준영 on 11/19/24.
//

import Foundation

protocol SocketEventHandler {
    func handler(event: SocketEvent, data: Data)
}
