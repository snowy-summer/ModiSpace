//
//  DMChatView.swift
//  ModiSpace
//
//  Created by 전준영 on 11/16/24.
//

import SwiftUI

struct DMChatView: View {
    
    let dm: DMSDTO
    private var socketManager: SocketIOManager
    
    init(dm: DMSDTO) {
        self.dm = dm
        socketManager = SocketIOManager(router: SocketRouter.dm(roomID: dm.roomID))
    }
    
    var body: some View {
        VStack {
            Text("채팅방: \(dm.user.nickname)")
                .font(.title)
                .padding()
            
            Text("Room ID: \(dm.roomID)")
                .padding()
            
            Button("메시지 보내기") {
                
            }
        }
        .onAppear {
            socketManager.connect()
        }
        .onDisappear {
            socketManager.disconnect()
        }
    }
}
