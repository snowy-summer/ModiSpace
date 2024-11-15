//
//  ChangeChannelManagerView.swift
//  ModiSpace
//
//  Created by 최승범 on 11/15/24.
//

import SwiftUI

struct ChangeChannelManagerView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var model: ChangeChannelManagerModel
    
    init(model: ChangeChannelManagerModel) {
        _model = StateObject(wrappedValue: model)
    }
    
    var body: some View {
        List {
            ForEach(model.memberList, id: \.userID) { member in
                
                MemberInfoCell(type: .channel,
                               channelMember: member)
                .onTapGesture {
                    model.apply(.selectMember(member))
                    model.apply(.showAlert)
                }
                
            }
        }
        .listStyle(.plain)
        .overlay {
            if model.isShowAlert {
                Rectangle()
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            model.apply(.dontShowAlert)
                        }
                    }
                
                AlertView(
                    title: "\(model.selectedMember?.nickname ?? "미설정")님을 관리자로 지정하시겠습니까?",
                    message: """
                            채널 관리자에게는 다음과 같은 권한이 있습니다.
                            • 채널 이름 또는 설명 변경
                            • 채널 삭제
                            """,
                    primaryButtonText: "취소",
                    secondaryButtonText: "확인",
                    onPrimaryButtonTap: { model.apply(.dontShowAlert) },
                    onSecondaryButtonTap: { model.apply(.changeManager) }
                )
            }
        }
        .onAppear() {
            model.apply(.fetchMemberList)
        }
        .onChange(of: model.isExpiredRefreshToken) {
            setRootView(what: OnboardingView())
        }
    }
    
}
