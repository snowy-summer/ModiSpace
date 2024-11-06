//
//  ChangeManagerView.swift
//  ModiSpace
//
//  Created by 최승범 on 11/6/24.
//

import SwiftUI

struct ChangeManagerView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var model: ChangeManagerModel = ChangeManagerModel()
    
    var body: some View {
        List {
            ForEach(model.memberList, id: \.userID) { member in
                
                MemberInfoCell(member: member)
                    .onTapGesture {
                        model.apply(.saveMember(member))
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
                    title: " \(model.selectedMember?.nickname ?? "미설정")님을 관리자로 지정하시겠습니까?",
                    message: """
                            워크스페이스 관리자에게는 다음과 같은 권한이 있습니다.
                            • 워크스페이스 이름 또는 설명 변경
                            • 워크스페이스 삭제
                            • 워크스페이스 멤버 초대
                            """,
                    primaryButtonText: "취소",
                    secondaryButtonText: "확인",
                    onPrimaryButtonTap: { model.apply(.dontShowAlert) },
                    onSecondaryButtonTap: { model.apply(.changeManager) }
                )
            }
        }
        .onAppear() {
            model.apply(.viewAppear)
        }
    }
    
}
