//
//  MemberInfoCell.swift
//  ModiSpace
//
//  Created by 최승범 on 11/6/24.
//

import SwiftUI

struct MemberInfoCell: View {
    
    let member: WorkspaceMemberDTO
    
    var body: some View {
        HStack {
            if let profileString = member.profileImage {
                AsyncImageView(path: profileString)
                    .customRoundedRadius()
            } else {
                Image(.temp)
                    .resizable()
                    .customRoundedRadius()
            }
            
            VStack(alignment: .leading) {
                Text(member.nickname)
                    .customFont(.bodyBold)
                Text(member.email)
                    .customFont(.caption)
                    .foregroundStyle(.textSecondary)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
    
}
