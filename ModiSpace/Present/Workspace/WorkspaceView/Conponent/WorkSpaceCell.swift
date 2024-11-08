//
//  WorkSpaceCell.swift
//  ModiSpace
//
//  Created by 최승범 on 10/25/24.
//

import SwiftUI

struct WorkSpaceCell: View {
    
    let workspace: WorkspaceState
    let selected: Bool
    let model: SideMenuModel
    
    var body: some View {
        HStack {
            AsyncImageView(path: workspace.coverImageString)
                .customRoundedRadius()
            
            VStack(alignment: .leading) {
                Text(workspace.name)
                    .customFont(.bodyBold)
                Text(workspace.createdAt)
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
