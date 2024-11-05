//
//  WorkspaceState.swift
//  ModiSpace
//
//  Created by 최승범 on 11/4/24.
//

import SwiftUI

struct WorkspaceState {
    
    let workspaceID: String
    let name: String
    let description: String
    let coverImageString: String
    var coverImage: UIImage
    let ownerID: String
    var createdAt: String
    let channels: [ChannelDTO]
    let workspaceMembers: [WorkspaceMemberDTO]
    
    init(workspaceID: String = "",
         name: String = "",
         description: String = "",
         coverImageString: String = "",
         coverImage: UIImage = UIImage(),
         ownerID: String = "",
         createdAt: String = "",
         channels: [ChannelDTO] = [],
         workspaceMembers: [WorkspaceMemberDTO] = []) {
        
        self.workspaceID = workspaceID
        self.name = name
        self.description = description
        self.coverImageString = coverImageString
        self.coverImage = coverImage
        self.ownerID = ownerID
        self.createdAt = createdAt
        self.channels = channels
        self.workspaceMembers = workspaceMembers
    }
    
}
