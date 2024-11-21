//
//  SocketIOManager.swift
//  ModiSpace
//
//  Created by 전준영 on 11/19/24.
//

import Foundation
import Combine
import SocketIO

final class SocketIOManager {
    private var manager: SocketManager?
    private var socket: SocketIOClient?
    private let router: SocketRoutertProtocol
    private let decoder = JSONDecoder()
    
    let dataPublisher = PassthroughSubject<Data, Never>()
    
    init(router: SocketRoutertProtocol) {
        self.router = router
        setupSocket()
        setupSocketEvent()
    }
    
    func connect() {
        socket?.connect()
    }
    
    func disconnect() {
        socket?.disconnect()
    }
    
    private func setupSocket() {
        guard let url = router.baseURL else {
            print("잘못된 URL")
            return
        }
        let configuration = SocketIOClientConfiguration(arrayLiteral: .log(true), .compress)
        manager = SocketManager(socketURL: url, config: configuration)
        socket = manager?.socket(forNamespace: router.nameSpace)
    }
    
    private func setupSocketEvent() {
        socket?.on(clientEvent: .connect) { _, _ in
            print("소켓 연결")
        }
        
        socket?.on(clientEvent: .disconnect) { _, _ in
            print("소켓 해제")
        }
        
        socket?.on(router.event) { [weak self] data, _ in
            guard let self = self else { return }
            guard let rawData = data.first as? [String: Any],
                  let jsonData = try? JSONSerialization.data(withJSONObject: rawData) else {
                print("디코딩 실패")
                return
            }
            dataPublisher.send(jsonData)
        }
    }
    
}
