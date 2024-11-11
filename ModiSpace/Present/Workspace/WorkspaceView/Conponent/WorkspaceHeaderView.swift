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
            action: {
                print("스타 버튼 클릭")
            }
        )
    }
    
}
