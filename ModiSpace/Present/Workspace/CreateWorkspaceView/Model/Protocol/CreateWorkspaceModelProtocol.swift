//
//  CreateWorkspaceModelProtocol.swift
//  ModiSpace
//
//  Created by 최승범 on 10/26/24.
//

import SwiftUI

protocol CreateWorkspaceModelStateProtocol {
    
    var workspaceImage: [UIImage] { get }
    var workspaceName: String { get }
    var workspaceDescription: String { get }
    var isCreateAbled: Bool { get }
    
}
