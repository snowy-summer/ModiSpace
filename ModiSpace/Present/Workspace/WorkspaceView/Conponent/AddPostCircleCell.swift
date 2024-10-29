//
//  AddPostCircleCell.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct AddPostCircleCell: View {
    
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(.main)
                    .frame(width: 60, height: 60)
                    .shadow(radius: 4)
                
                Image(systemName: "square.and.pencil")
                    .font(.system(size: 24))
                    .foregroundStyle(.white)
            }
        }
    }
    
}
