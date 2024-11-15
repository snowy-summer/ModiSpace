//
//  ChangeChannelManagerIntent.swift
//  ModiSpace
//
//  Created by 최승범 on 11/15/24.
//

import Foundation

enum ChangeChannelManagerInent {
    
    case expiredRefreshToken
    case changeManager
    case fetchMemberList
    case showAlert
    case dontShowAlert
    case selectMember(OtherUserDTO)
    
}
