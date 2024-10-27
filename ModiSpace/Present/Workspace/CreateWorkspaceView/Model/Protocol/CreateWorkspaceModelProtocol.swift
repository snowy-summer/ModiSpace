//
//  CreateWorkspaceModelProtocol.swift
//  ModiSpace
//
//  Created by 최승범 on 10/26/24.
//

import Foundation

protocol CreateWorkspaceModelActionsProtocol: AnyObject {
   
    func updateWorkspaceName(_ name: String)
    func updateWorkspaceDescription(_ description: String)
    
}

protocol CreateWorkspaceModelStateProtocol {
    
    var workspaceName: String { get }
    var workspaceDescription: String { get }
    var isCreateAbled: Bool { get }
    
}
