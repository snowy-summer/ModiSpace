//
//  WorkSpaceCell.swift
//  ModiSpace
//
//  Created by 최승범 on 10/25/24.
//

import SwiftUI

struct WorkSpaceCell: View {
    
    let titleText: String
    let dateText: String
    let imageString: String
    var selected: Bool
    var model: SideMenuModel
    
    var body: some View {
        HStack {
            AsyncImageView(path: imageString)
                .customRoundedRadius()
            
            VStack(alignment: .leading) {
                Text(titleText)
                    .customFont(.bodyBold)
                Text(dateText)
                    .customFont(.caption)
                    .foregroundStyle(.textSecondary)
            }
            Spacer()
            if selected {
                Button(action: {
                    model.apply(.showMoreMenu)
                }) {
                    Image(systemName: "ellipsis")
                        .padding()
                }
                .buttonStyle(PlainButtonStyle())
                .contentShape(Rectangle())
            }
        }
        .frame(maxWidth: .infinity)
    }
    
}
//
//#Preview {
//    WorkSpaceCell(titleText: "워크",
//                  dateText: "2024.03.11",
//                  imageString: "", selected: true)
//}
