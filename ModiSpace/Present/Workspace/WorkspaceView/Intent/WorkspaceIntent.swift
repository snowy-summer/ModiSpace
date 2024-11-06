//
//  WorkspaceIntent.swift
//  ModiSpace
//
//  Created by 최승범 on 11/1/24.
//

import Foundation

enum WorkspaceIntent {
    
    case viewAppear
    case showSideView
    case dontShowSideView
    case showMemberAddView
    case showCreateWorkspaceView
    case showEditWorkspaceView(WorkspaceState)
    case showChangeManagerView
    case reloadChannelList
    case showDeleteAlert
    case dontShowDeleteAlert
    case deleteWorkspace
    case reloadWorkspaceList
    case exitWorkspace
    
}
