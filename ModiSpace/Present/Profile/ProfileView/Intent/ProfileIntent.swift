//
//  ProfileIntent.swift
//  ModiSpace
//
//  Created by 전준영 on 11/12/24.
//

import Foundation

enum ProfileIntent {
    
    case viewAppear
    case nickname(String, Bool)
    case phone(String, Bool)
    case showImagePicker
    case myProfileImageChange
    case showLogoutAlertView
    case dontShowLogoutAlert
    case expiredRefreshToken
    case logout
    
}
