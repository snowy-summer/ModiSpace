//
//  MemberInfoCell.swift
//  ModiSpace
//
//  Created by 최승범 on 11/6/24.
//

import SwiftUI

struct MemberInfoCell: View {
    
    enum MemberType {
        case workspace
        case channel
    }
    
    let type: MemberType
    let workspaceMember: WorkspaceMemberDTO?
    let channelMember: OtherUserDTO?
    
    init(type: MemberType,
         workspaceMember: WorkspaceMemberDTO? = nil,
         channelMember: OtherUserDTO? = nil) {
        self.type = type
        self.workspaceMember = workspaceMember
        self.channelMember = channelMember
    }
    
    var body: some View {
        if type == .workspace {
            HStack {
                if let profileString = workspaceMember?.profileImage {
                    AsyncImageView(path: profileString)
                        .customRoundedRadius()
                } else {
                    Image(.temp)
                        .resizable()
                        .customRoundedRadius()
                }
                
                VStack(alignment: .leading) {
                    Text(workspaceMember!.nickname)
                        .customFont(.bodyBold)
                    Text(workspaceMember!.email)
                        .customFont(.caption)
                        .foregroundStyle(.textSecondary)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
        } else {
            HStack {
                if let profileString = channelMember?.profileImage {
                    AsyncImageView(path: profileString)
                        .customRoundedRadius()
                } else {
                    Image(.temp)
                        .resizable()
                        .customRoundedRadius()
                }
                
                VStack(alignment: .leading) {
                    Text(channelMember!.nickname)
                        .customFont(.bodyBold)
                    Text(channelMember!.email)
                        .customFont(.caption)
                        .foregroundStyle(.textSecondary)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
    }
    
}
