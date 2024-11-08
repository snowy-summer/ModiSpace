//
//  WorkspaceIDManager.swift
//  ModiSpace
//
//  Created by 최승범 on 11/4/24.
//

import Foundation

final class WorkspaceIDManager: ObservableObject {
    static let shared = WorkspaceIDManager()
    
    @Published var workspaceID: String? {
        didSet {
            UserDefaults.standard.set(workspaceID, forKey: "workspaceID")
        }
    }
    
    private init() {
        self.workspaceID = UserDefaults.standard.string(forKey: "workspaceID")
    }
}
