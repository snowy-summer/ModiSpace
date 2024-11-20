//
//  SocketEventProtocol.swift
//  ModiSpace
//
//  Created by 전준영 on 11/19/24.
//

import Foundation

protocol SocketEventProtocol {
    var url: URL { get throws }
    var nameSpace: SocketNameSpace { get }
    var events: [SocketEvent] { get }
    var handler: SocketEventHandler { get }
}
