//
//  WorkspaceIDManager.swift
//  ModiSpace
//
//  Created by 최승범 on 11/4/24.
//

import Foundation

final class WorkspaceIDManager {
    
    static let shared = WorkspaceIDManager()
    
    private init() { }
      
      var workspaceID: String? {
          get {
              UserDefaults.standard.string(forKey: "workspaceID")
          }
          set {
              UserDefaults.standard.set(newValue, forKey: "workspaceID")
          }
      }
    
}
