//
//  MemberCell.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct MemberCell: View {
    var body: some View {
        VStack {
            Image(systemName: "star")
                .resizable()
                .background(Color.green)
                .frame(width: 44, height: 44)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            Text("jack")
                .font(.system(size: 14))
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
        }
        
    }
}

#Preview {
    MemberCell()
}
