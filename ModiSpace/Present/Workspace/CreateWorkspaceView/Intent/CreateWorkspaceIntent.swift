//
//  CreateWorkspaceIntent.swift
//  ModiSpace
//
//  Created by 최승범 on 10/26/24.
//

import SwiftUI

enum CreateWorkspaceIntent {
    
    case createWorkspace
    case editWorkspace
    case updateName(String)
    case updateImage(UIImage)
    case updateDescription(String)
    case showImagePicker
    
}
