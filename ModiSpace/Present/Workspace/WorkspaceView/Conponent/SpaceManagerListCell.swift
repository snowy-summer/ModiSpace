//
//  SpaceManagerListCell.swift
//  ModiSpace
//
//  Created by 최승범 on 10/25/24.
//

import SwiftUI

struct SpaceManagerListCell: View {
   
    let profileImage = UIImage(resource: .temp)
    let managerName = "끼얏호우"
    let email = "huhuhoho@example.com"
    
    var body: some View {
        HStack {
            Image(uiImage: profileImage)
                .resizable()
                .frame(width: 44, height: 44)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.trailing, 8)
            
            VStack(alignment: .leading) {
                Text(managerName)
                    .customFont(.bodyBold)
                Text(email)
                    .customFont(.caption)
                    .foregroundStyle(.textSecondary)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
    
}

#Preview {
    SpaceManagerListCell()
}