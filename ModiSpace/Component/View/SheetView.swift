//
//  SheetView.swift
//  ModiSpace
//
//  Created by 최승범 on 11/5/24.
//

import SwiftUI

struct SheetView: View {
    
    @EnvironmentObject var model: WorkspaceModel
    var type: WorkspaceViewSheetType
    
    var body: some View {
        switch type {
        case .createWorkspace:
            CreateWorkspaceView()
            
        case .editWorkspace(let workspaceState):
            CreateWorkspaceView(workspace: workspaceState)
            
        case .changeWorkspaceManager:
            Rectangle()
            
        case .addChannelView:
            RegisterChannelView {
                
            }
            
        case .addMemberView:
            Rectangle()
        }
    }
    
}

enum WorkspaceViewSheetType: Identifiable {
    
    case createWorkspace
    case editWorkspace(WorkspaceState)
    case changeWorkspaceManager
    case addChannelView
    case addMemberView
    
    var id: String {
        switch self {
        case .createWorkspace:
            return "createWorkspace"
            
        case .editWorkspace:
            return "editWorkspace"
            
        case .changeWorkspaceManager:
            return "changeWorkspaceManager"
            
        case .addChannelView:
            return "addChannelView"
            
        case .addMemberView:
            return "addMemberView"
        }
    }
    
}
