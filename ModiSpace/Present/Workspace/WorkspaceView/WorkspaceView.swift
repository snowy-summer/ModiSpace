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
            .sheet(isPresented: $model.isShowEditWorkspaceView) {
                if let workspace = model.selectedWorkspace {
                    CreateWorkspaceView(workspace: workspace) {
//                        model.apply(.fetchWorkspaceList)
                    }
                }
            }
            .onAppear() {
                model.fetchWorkspace()
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
