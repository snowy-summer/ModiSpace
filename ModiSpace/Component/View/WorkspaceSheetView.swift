//
//  WorkspaceSheetView.swift
//  ModiSpace
//
//  Created by 최승범 on 11/5/24.
//

import SwiftUI

struct WorkspaceSheetView: View {
    
    @EnvironmentObject var model: WorkspaceModel
    var type: WorkspaceViewSheetType
    
    var body: some View {
        NavigationStack {
            switch type {
            case .createWorkspace:
                CreateWorkspaceView()
                    .navigationTitle("워크 스페이스 생성")
                    .navigationBarTitleDisplayMode(.inline)
                
            case .editWorkspace(let workspaceState):
                CreateWorkspaceView(workspace: workspaceState)
                    .navigationTitle("워크 스페이스 편집")
                    .navigationBarTitleDisplayMode(.inline)
                
            case .changeWorkspaceManager:
                ChangeManagerView()
                    .navigationTitle("워크 스페이스 매니저 변경")
                    .navigationBarTitleDisplayMode(.inline)
                
            case .addChannelView:
                RegisterChannelView()
                    .navigationTitle("채널 등록")
                    .navigationBarTitleDisplayMode(.inline)
                
            case .findChannelView:
                FindChannelView()
                    .navigationTitle("채널 탐색")
                    .navigationBarTitleDisplayMode(.inline)
                
            case .addMemberView:
                AddMemberView()
                    .navigationTitle("팀원 초대")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    
}

enum WorkspaceViewSheetType: Identifiable {
    
    case createWorkspace
    case editWorkspace(WorkspaceState)
    case changeWorkspaceManager
    case addChannelView
    case findChannelView
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
            
        case .findChannelView:
            return "findChannelView"
            
        case .addMemberView:
            return "addMemberView"
        }
    }
    
}
