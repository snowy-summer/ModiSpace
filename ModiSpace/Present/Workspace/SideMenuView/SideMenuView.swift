//
//  SideMenuView.swift
//  ModiSpace
//
//  Created by 최승범 on 10/27/24.
//

import SwiftUI

struct SideMenuView: View {
    
    @EnvironmentObject var workspaceModel: WorkspaceModel
    @StateObject var model = SideMenuModel()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                SideMenuHeaderView()
                    .padding(.top, 40)
                
                Spacer()
                
                if workspaceModel.isWorkspaceEmpty {
                    SideMenuEmptyContentView()
                } else  {
                    SideMenuNoneEmptyContentView(model: model)
                }
                
                SFSubButton(text: "워크스페이스 추가") {
                    workspaceModel.apply(.showCreateWorkspaceView)
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
        .overlay(
            ChannelActionSheet(
                isPresented: $model.isShowMoreMenu,
                actions: [
                    .default(Text("워크스페이스 편집")) {
                        workspaceModel.apply(.showEditWorkspaceView(workspaceModel.selectedWorkspace!))
                    },
                    .default(Text("워크스페이스 나가기")) {
                        workspaceModel.apply(.exitWorkspace)
                    },
                    .default(Text("워크스페이스 관리자 변경")) {
                        workspaceModel.apply(.showChangeManagerView)
                    },
                    .destructive(Text("워크스페이스 삭제")) {
                        workspaceModel.isShowDeleteAlertView = true
                    },
                    .cancel(Text("취소"))
                ]
            )
        )
    }
    
}

#Preview {
    SideMenuView()
}
