//
//  SideMenuModel.swift
//  ModiSpace
//
//  Created by 최승범 on 11/1/24.
//

import Foundation
import Combine

final class SideMenuModel: ObservableObject {
    
    @Published var isShowHelpGuide: Bool = false
    @Published var isShowMoreMenu: Bool = false
    @Published var isShowCreateWorkspaceView: Bool = false
        
    private let networkManager = NetworkManager()
    private let dateManager = DateManager()
    private var cancelable = Set<AnyCancellable>()
    
    func apply(_ intent: SideMenuIntnet) {
        
        switch intent {
            
        case .changeWorkspace:
            isShowMoreMenu = true
            
        case .addWorkspace:
            isShowCreateWorkspaceView = true
            
        case .showHelpGuide:
            isShowHelpGuide = true
            
        case .showMoreMenu:
            isShowMoreMenu = true
            
        case .selectWorkspace(let workspace):
            WorkspaceIDManager.shared.workspaceID = workspace.workspaceID
        }
    }
    
}
