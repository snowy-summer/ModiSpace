//
//  DMListCell.swift
//  ModiSpace
//
//  Created by 전준영 on 10/26/24.
//

import SwiftUI

struct DMListCell: View {
    
    let profileImage: String
    let userNickname: String
    let message: String
    let time: String
    let badgeCount: Int
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(profileImage)
                .resizable()
                .frame(width: 44, height: 44)
                .cornerRadius(15)
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text(userNickname)
                    .customFont(.title2)
                
                Text(message)
                    .customFont(.caption)
                    .foregroundStyle(.gray)
                    .lineLimit(2)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                
                Text(time)
                    .customFont(.caption)
                    .foregroundStyle(.gray)
                
                if badgeCount > 0 {
                    Text("\(badgeCount)")
                        .customFont(.caption)
                        .foregroundStyle(.white)
                        .padding(8)
                        .background(Circle().fill(.main))
                }
                
            }
        }
        .padding(.horizontal, 12)
        
    }
    
}


#Preview {
    DMListCell(profileImage: "tempImage", userNickname: "옹골찬 고래밥", message: "오늘 정말 고생이 많으셨습니다!!오늘 정말 고생이 많으셨습니다!!오늘 정말 고생이 많으셨습니다!!", time: "PM 11:23", badgeCount: 2)
}
