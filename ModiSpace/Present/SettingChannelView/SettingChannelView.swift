//
//  SettingChannelView.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct SettingChannelView: View {
    
    @StateObject var model: ChatModel
    
    var body: some View {
        VStack {
            SettingChannelHeaderView(model: model)
            
            MemberList()
            
            SettingChannelButton(title: "채널 편집") {
                model.apply(.showEditChannelView)
            }
            
            SettingChannelButton(title: "채널에서 나가기") { }
            
            SettingChannelButton(title: "채널 관리자 변경") { }
            
            SettingChannelButton(title: "채널 삭제") {
                model.isShowDeleteAlertView = true
            }
        }
        .overlay(
            Group {
                if model.isShowDeleteAlertView {
                    AlertView(
                        title: "채널 삭제",
                        message: "정말 이 채널을 삭제하시겠습니까? 삭제 시 모든 데이터가 사라지며 복구할 수 없습니다.",
                        primaryButtonText: "취소",
                        secondaryButtonText: "삭제",
                        onPrimaryButtonTap: { model.apply(.dontShowDeleteAlert) },
                        onSecondaryButtonTap: { model.apply(.deleteChannel) }
                    )
                }
            }
        )
        .sheet(isPresented: $model.isShowingEditChannelView) {
                   EditChannelView(model: model)
               }
        .onChange(of: model.isChannelDeleted) { isDeleted in
            if isDeleted {
                switchToWorkspaceView()
            }
        }
    }
    
}

extension SettingChannelView {
    
    func switchToWorkspaceView() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let keyWindow = windowScene.windows.first {
            keyWindow.rootViewController = UIHostingController(rootView: WorkspaceView())
            keyWindow.makeKeyAndVisible()
        }
    }
    
}
