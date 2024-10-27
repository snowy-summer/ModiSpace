//
//  CreateWorkspaceIntent.swift
//  ModiSpace
//
//  Created by 최승범 on 10/26/24.
//

import Foundation

final class CreateWorkspaceIntent: CreateWorkspaceIntentProtocol {
    
    private weak var model: CreateWorkspaceModelActionsProtocol?
    
    init(model: CreateWorkspaceModelActionsProtocol? = nil) {
        self.model = model
    }
    
    func setModel(_ model: CreateWorkspaceModelActionsProtocol) {
        self.model = model
    }
    
    func createWorkspace() {
        
    }
    
    func updateWorkspaceName(_ name: String) {
        model?.updateWorkspaceName(name)
    }
    
    func updateWorkspaceDescription(_ description: String) {
        model?.updateWorkspaceDescription(description)
    }
    
}
