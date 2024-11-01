//
//  SideMenuView.swift
//  ModiSpace
//
//  Created by 최승범 on 10/27/24.
//

import SwiftUI

struct SideMenuView: View {
    
    @StateObject var model = SideMenuModel()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                SideMenuHeaderView()
                    .padding(.top, 40)
                
                Spacer()
                
                if model.isWorkspaceEmpty {
                    SideMenuEmptyContentView(model: model)
                } else  {
                    SideMenuNoneEmptyContentView(model: model)
                }
                
                SFSubButton(text: "워크스페이스 추가") {
                    model.apply(.addWorkspace)
                }
                    .padding()
                
                SFSubButton(text: "도움말") {
                    model.apply(.showHelpGuide)
                }
                    .padding(.horizontal)
                    .padding(.bottom, 40)
                    
                Spacer()
            }
            .frame(width: 300)
            .background(.white)
            .customCornerRadius(20,
                                corners: [.topRight, .bottomRight])
            .ignoresSafeArea()

            
            Spacer()
        }
        .onAppear() {
            model.apply(.fetchWorkspaceList)
        }
        .sheet(isPresented: $model.isShowCreateWorkspaceView) {
            CreateWorkspaceView()
        }
    }
    
}

#Preview {
    SideMenuView()
}
