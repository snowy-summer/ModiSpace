//
//  CreateWorkspaceIntentProtocol.swift
//  ModiSpace
//
//  Created by 최승범 on 10/26/24.
//

import Foundation

protocol CreateWorkspaceIntentProtocol {
    
    func createWorkspace()
    func updateWorkspaceName(_ name: String)
    func updateWorkspaceDescription(_ description: String)
    
}
