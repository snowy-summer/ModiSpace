//
//  DMEventHandler.swift
//  ModiSpace
//
//  Created by 전준영 on 11/19/24.
//

import Foundation

struct DMEventHandler: SocketEventHandler {
    private let decoder = JSONDecoder()
    
    func handler(event: SocketEvent, data: Data) {
        switch event {
        case .dm:
            receiveDMMessage(message: data)
        default:
            break
        }
    }
    
    private func receiveDMMessage(message data: Data) {
        do {
            let decodedData = try decoder.decode(DMSDTO.self, from: data)
            print(decodedData)
        } catch {
            print(error)
        }
    }
}
