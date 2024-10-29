//
//  CreateWorkspaceModel.swift
//  ModiSpace
//
//  Created by 최승범 on 10/26/24.
//

import Foundation

final class CreateWorkSpaceModel: ObservableObject, CreateWorkspaceModelStateProtocol {
    
    @Published var workspaceName = ""
    @Published var workspaceDescription = ""
    
    var isCreateAbled: Bool {
        !workspaceName.isEmpty
    }
    
}

extension CreateWorkSpaceModel: CreateWorkspaceModelActionsProtocol {
    
    func updateWorkspaceName(_ name: String) {
        workspaceName = name
    }
    
    func updateWorkspaceDescription(_ description: String) {
        workspaceDescription = description
    }
    
}
