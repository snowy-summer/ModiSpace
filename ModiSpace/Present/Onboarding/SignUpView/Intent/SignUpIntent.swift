//
//  SignUpIntent.swift
//  ModiSpace
//
//  Created by 전준영 on 11/3/24.
//

import Foundation

enum SignUpIntent {
    
    case validateEmail(String)
    case validateNickname(String)
    case validatePhoneNumber(String)
    case validatePassword(String)
    case validateConfirmPassword(String)
    case checkEmailDuplicate
    case checkSignUpEnabled
    
}
