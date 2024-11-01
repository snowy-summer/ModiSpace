//
//  WorkspaceHeaderView.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct WorkspaceHeaderView: View {
    
    var body: some View {
        HStack {
            Image(systemName: "star")
                .resizable()
                .background(Color.green)
                .customRoundedRadius()
            
            Text("iOS Developers Study")
                .font(.system(size: 20, weight: .bold))
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "star")
                    .resizable()
                    .background(.main)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.black, lineWidth: 3)
                    )
            }
        }
        .padding()
    }
    
}

