//
//  WorkspaceHeaderView.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct WorkspaceHeaderView: View {
    
    @ObservedObject var model: WorkspaceModel
    
    var body: some View {
        HeaderView(
            coverImage: model.selectedWorkspace?.coverImage ?? UIImage(resource: .temp),
            name: model.selectedWorkspace?.name ?? "아무 값 없음",
            profileImage: model.profileImage ?? UIImage(resource: .temp),
            action: {
                model.isShowProfileView = true
            }
        )
        NavigationLink(destination: ProfileView(),
                       isActive: $model.isShowProfileView) {
            EmptyView()
        }
        .onAppear {
            model.apply(.profileMe)
        }
    }
    
}
