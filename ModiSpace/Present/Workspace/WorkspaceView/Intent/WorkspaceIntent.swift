//
//  WorkspaceIntent.swift
//  ModiSpace
//
//  Created by 최승범 on 11/1/24.
//

import Foundation
import SwiftData

enum WorkspaceIntent {
    
    case insertModelContext(ModelContext)
    case fetchWorkspaceList
    case expiredRefreshToken
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
    case profileMe
    
}
