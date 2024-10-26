//
//  ProfileNickView.swift
//  ModiSpace
//
//  Created by 전준영 on 10/26/24.
//

import SwiftUI

struct ProfileNickView: View {
    
    let profile: String
    let nickText: String
    
    var body: some View {
        VStack {
            Image(profile)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 44, height: 44)
                .background(Color(.gray))
                .cornerRadius(15)
            
            Text(nickText)
                .customFont(.caption)
                .foregroundStyle(.primary)
        }
    }
}

#Preview {
    ProfileNickView(profile: "tempImage", nickText: "Sam")
}
