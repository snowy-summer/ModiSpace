//
//  SocketIOManager.swift
//  ModiSpace
//
//  Created by 전준영 on 11/19/24.
//

import Foundation
import SocketIO

final class SocketIOManager: ObservableObject {
    private var manager: SocketManager?
    private var socket: SocketIOClient?
    private let router: SocketRouter
    private let decoder = JSONDecoder()
    
    init(router: SocketRouter) {
        self.router = router
        setupSocket()
    }
    
    func connect() {
        socket?.connect()
    }
    
    func disconnect() {
        socket?.disconnect()
    }
    
    private func setupSocket() {
        guard let url = router.baseURL else {
            print("Invalid URL")
            return
        }
        let configuration = SocketIOClientConfiguration(arrayLiteral: .log(true), .compress)
        manager = SocketManager(socketURL: url, config: configuration)
        socket = manager?.socket(forNamespace: router.path)
        
        setupSocketEvent()
    }
    
    private func setupSocketEvent() {
        socket?.on(clientEvent: .connect) { _, _ in
            print("Socket Connected")
        }
        
        socket?.on(clientEvent: .disconnect) { _, _ in
            print("Socket Disconnected")
        }
        
        socket?.on(router.event) { [weak self] data, _ in
            guard let self = self else { return }
            guard let rawData = data.first as? [String: Any],
                  let jsonData = try? JSONSerialization.data(withJSONObject: rawData) else {
                print("Failed to parse JSON data")
                return
            }
            self.receiveMessage(data: jsonData)
        }
    }
    
    private func receiveMessage(data: Data) {
        do {
            let decodedData = try decoder.decode(SocketDTO.self, from: data)
            print(decodedData)
        } catch {
            print("Decoding error: \(error)")
        }
    }
}
