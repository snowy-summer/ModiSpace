//
//  SideMenuModel.swift
//  ModiSpace
//
//  Created by 최승범 on 11/1/24.
//

import Foundation

final class SideMenuModel: ObservableObject {
    
    @Published var workspaceList: [WorkspaceDTO] = []
    @Published var isShowHelpGuide: Bool = false
    @Published var isShowMoreMenu: Bool = false
    @Published var isShowCreateWorkspaceView: Bool = false
    
    var isWorkspaceEmpty: Bool {
        workspaceList.isEmpty
    }
    
    private let networkManager = NetworkManager()
    
    func apply(_ intent: SideMenuIntnet) {
        
        switch intent {
        case .fetchWorkspaceList:
            fetchWorkspaceList()
        
        case .changeWorkspace:
            isShowMoreMenu = true
            
        case .addWorkspace:
            isShowCreateWorkspaceView = true
            
        case .showHelpGuide:
            isShowHelpGuide = true
            
        case .showMoreMenu:
            isShowMoreMenu = true
        }
    }
}

extension SideMenuModel {
    
    private func fetchWorkspaceList() {
        Task {
            do {
                let list = try await networkManager.getDecodedData(from: WorkSpaceRouter.getWorkSpaceList) as! [WorkspaceDTO]
                DispatchQueue.main.async { [weak self] in
                    self?.workspaceList = list
                }
            }
        }
    }
    
}
