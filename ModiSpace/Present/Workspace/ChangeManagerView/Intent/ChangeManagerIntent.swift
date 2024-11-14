//
//  ChangeManagerIntent.swift
//  ModiSpace
//
//  Created by 최승범 on 11/6/24.
//

import Foundation

enum ChangeManagerInent {
    
    case expiredRefreshToken
    case changeManager
    case fetchMemberList
    case showAlert
    case dontShowAlert
    case saveMember(WorkspaceMemberDTO)
    
}
