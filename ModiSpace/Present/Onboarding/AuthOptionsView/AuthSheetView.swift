//
//  AuthSheetView.swift
//  ModiSpace
//
//  Created by 최승범 on 11/12/24.
//

import SwiftUI

struct AuthSheetView: View {
    
    var type: AuthSheetType
    
    var body: some View {
        
        switch type {
        case .signIn:
            SignInView()
            
        case .signUp:
            SignUpView()
        }
    }
}


enum AuthSheetType: Identifiable {
    
    case signIn
    case signUp
    
    var id: String {
        switch self {
        case .signIn:
            return "singIn"
            
        case .signUp:
            return "signUp"
        }
    }
    
    var title: String {
        switch self {
        case .signIn:
            return "이메일 로그인"
            
        case .signUp:
            return "회원가입"
        }
    }
}


