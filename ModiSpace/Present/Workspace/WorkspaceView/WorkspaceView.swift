//
//  ChannelView_Home.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct WorkspaceView: View {
    
    @StateObject var model = WorkspaceModel()
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack {
                    WorkspaceHeaderView(model: model)
                        .onTapGesture {
                            withAnimation {
                                model.apply(.showSideView)
                            }
                        }
                    
                    Divider()
                    
                    ScrollView{
                        CategoryListView()
                            .environmentObject(model)
                        
                        SFSubButton(text: "팀원 추가") {
                            model.apply(.showMemberAddView)
                        }
                        .padding()
                        
                        Spacer()
                    }
                }
                .overlay {
                    
                    if model.isShowSideView {
                        Rectangle()
                            .opacity(0.3)
                            .ignoresSafeArea()
                            .onTapGesture {
                                withAnimation {
                                    model.apply(.dontShowSideView)
                                }
                            }
                        
                        SideMenuView()
                            .environmentObject(model)
                            .transition(.move(edge: .leading))
                            .dragGesture(direction: .left) {
                                model.apply(.dontShowSideView)
                            }
                    }
                }
                
                AddPostCircleCell {}
                    .frame(width: 50, height: 50)
                    .position(x: geometry.size.width - 45,
                              y: geometry.size.height - 35)
            }
            .overlay {
                if model.isShowDeleteAlertView {
                    Rectangle()
                        .opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation {
                                model.apply(.dontShowDeleteAlert)
                            }
                        }
                    AlertView(
                        title: "워크스페이스 삭제",
                        message: "정말 이 워크스페이스를 삭제하시겠습니까? 삭제 시 모든 데이터가 사라지며 복구할 수 없습니다.",
                        primaryButtonText: "취소",
                        secondaryButtonText: "삭제",
                        onPrimaryButtonTap: { model.apply(.dontShowDeleteAlert) },
                        onSecondaryButtonTap: { model.apply(.deleteWorkspace) }
                    )
                }
            }
            .sheet(item: $model.sheetType,
                   onDismiss: {
                model.apply(.reloadWorkspaceList)
            }) { type in
                SheetView(type: type)
            }
            .onAppear() {
                model.apply(.viewAppear)
            }
            .navigationDestination(isPresented: $model.isShowNewMessageView) {
                NewMessageView()
            }
        }
    }
    
}

#Preview {
    WorkspaceView()
}
