//
//  SideMenuView.swift
//  ModiSpace
//
//  Created by 최승범 on 10/27/24.
//

import SwiftUI

struct SideMenuView: View {
    
    @Binding var isShowing: Bool
    var isWorkspaceEmpty = true
    
    var body: some View {
        ZStack {
            if isShowing {
                Rectangle()
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture { isShowing.toggle() }
                
                HStack {
                    VStack(alignment: .leading) {
                        SideMenuHeaderView()
                        
                        Spacer()
                        
                        if isWorkspaceEmpty {
                            SideMenuEmptyContentView()
                        } else  {
                            SideMenuNoneEmptyContentView()
                        }
                        
                        SFSubButton(text: "워크스페이스 추가") { print("aa")}
                            .padding()
                        SFSubButton(text: "도움말") {}
                            .padding(.horizontal)
                            .padding(.bottom)
                    }
                    .frame(width: 300)
                    .background(.white)
                    
                    Spacer()
                }
            }
        }
    }
    
}

#Preview {
    SideMenuView(isShowing: .constant(true))
}
