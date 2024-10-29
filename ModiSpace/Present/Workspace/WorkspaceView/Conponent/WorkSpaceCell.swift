//
//  WorkSpaceCell.swift
//  ModiSpace
//
//  Created by 최승범 on 10/25/24.
//

import SwiftUI

struct WorkSpaceCell: View {
    
    let image = UIImage(resource: .temp)
    let titleText = "test_ios Study"
    let dateText = "24. 10. 25"
    var selected = true
    
    var body: some View {
        HStack {
            Image(uiImage: image)
                .resizable()
                .frame(width: 44, height: 44)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.trailing, 8)
            VStack(alignment: .leading) {
                Text(titleText)
                    .customFont(.bodyBold)
                Text(dateText)
                    .customFont(.caption)
                    .foregroundStyle(.textSecondary)
            }
            Spacer()
            if selected {
                Image(systemName: "ellipsis")
                    .padding()
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    WorkSpaceCell()
}
