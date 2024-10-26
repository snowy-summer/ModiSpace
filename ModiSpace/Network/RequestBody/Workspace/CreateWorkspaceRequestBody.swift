//
//  CreateWorkspaceRequestBody.swift
//  ModiSpace
//
//  Created by 최승범 on 10/26/24.
//

import Foundation

struct CreateWorkspaceRequestBody: Encodable {
    
    let name: String
    let description: String?
    let image: String
    
}
