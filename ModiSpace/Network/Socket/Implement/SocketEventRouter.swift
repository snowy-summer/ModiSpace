//
//  SocketEventRouter.swift
//  ModiSpace
//
//  Created by 전준영 on 11/19/24.
//

import Foundation

final class SocketEventRouter {
    private var handlers: [SocketEvent: [SocketEventHandler]] = [:]
    
    func register(handler: SocketEventHandler, for events: [SocketEvent]) {
        for event in events {
            if handlers[event] == nil {
                handlers[event] = []
            }
            handlers[event]?.append(handler)
        }
    }
    
    func handleEvent(_ event: SocketEvent, data: Data) {
        handlers[event]?.forEach {
            $0.handler(event: event, data: data)
        }
    }
}
