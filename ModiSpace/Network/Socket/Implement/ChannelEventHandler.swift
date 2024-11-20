//
//  ChannelEventHandler.swift
//  ModiSpace
//
//  Created by 전준영 on 11/19/24.
//

import Foundation

struct ChannelEventHandler: SocketEventHandler {
    private let decoder = JSONDecoder()
    
    func handler(event: SocketEvent, data: Data) {
        switch event {
        case .channel:
            receiveChannelMessage(message: data)
        default:
            break
        }
    }
    
    private func receiveChannelMessage(message data: Data) {
        do {
            let decodedData = try decoder.decode(SocketDTO.self, from: data)
            print(decodedData)
        } catch {
            print(error)
        }
    }
}
