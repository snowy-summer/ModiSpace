//
//  SideMenuContentView.swift
//  ModiSpace
//
//  Created by 최승범 on 10/27/24.
//

import SwiftUI

//MARK: - EmptyContnent
struct SideMenuEmptyContentView: View {
    
    var model: SideMenuModel
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            
            Text("워크스페이스를\n찾을 수 없어요")
                .customFont(.title1)
                .padding(.horizontal)
            
            Text("관리자에게 초대를 요청하거나,\n 다른 이메일로 시도 하거나 \n 새로운 워크스페이스를 생성해주세요")
                .multilineTextAlignment(.center)
                .customFont(.body)
                .padding()
            
            CommonButton(icon: nil,
                         backgroundColor: .main,
                         text: "워크스페이스 생성",
                         textColor: .white,
                         symbolColor: nil,
                         cornerRadius: 8) {
                model.apply(.addWorkspace)
            }
                         .padding()
            
            Spacer()
        }
    }
    
}

//MARK: - NoneEmptyContent
struct SideMenuNoneEmptyContentView: View {
    
    var model: SideMenuModel
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            
            List {
                ForEach(model.workspaceList, id: \.workspaceID) { workspace in
                    WorkSpaceCell(titleText: workspace.name,
                                  dateText: workspace.createdAt,
                                  imageString: workspace.coverImage)
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
        }
    }
    
}
