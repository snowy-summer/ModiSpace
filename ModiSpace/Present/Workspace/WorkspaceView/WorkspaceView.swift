//
//  WorkspaceView.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct WorkspaceView: View {
    
    @ObservedObject var model: WorkspaceModel
    
    init(model: WorkspaceModel = WorkspaceModel()) {
        _model = ObservedObject(wrappedValue: model)
    }
    
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
                    
                    if model.isWorkspaceEmpty {
                        SideMenuEmptyContentView()
                            .environmentObject(model)
                    } else {
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
                }
                .dragGesture(direction: .right) {
                    model.apply(.showSideView)
                }
                
                AddPostCircleCell {}
                    .frame(width: 50, height: 50)
                    .position(x: geometry.size.width - 45,
                              y: geometry.size.height - 35)
            }
            .sheet(item: $model.sheetType,
                   onDismiss: {
                model.apply(.reloadWorkspaceList)
            }) { type in
                WorkspaceSheetView(type: type)
                    .presentationDragIndicator(.visible)
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
