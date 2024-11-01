//
//  WorkspaceModel.swift
//  ModiSpace
//
//  Created by 최승범 on 11/1/24.
//

import Foundation

final class WorkspaceModel: ObservableObject {
    
    @Published var isShowChannels = false
    @Published var isShowMessageList = false
    @Published var isShowNewMessageView = false
    @Published var isShowSideView = false
    @Published var isShowMemberAddView = false
    @Published var isShowChannelAddView = false
    
    
    func apply(_ intent: WorkspaceIntent) {
        
        switch intent {
        case .showChannels:
            isShowChannels = true
            
        case .showMessageList:
            isShowMessageList = true
            
        case .showNewMessageView:
            isShowNewMessageView = true
            
        case .showSideView:
            isShowSideView = true
            
        case .dontShowSideView:
            isShowSideView = false
            
        case .showMemberAddView:
            isShowMemberAddView = true
            
        case .showChannelAddView:
            isShowChannelAddView = true
            
        }
    }
    
}

extension WorkspaceModel {
    
}
