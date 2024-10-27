//
//  CreateWorkspaceView.swift
//  ModiSpace
//
//  Created by 최승범 on 10/26/24.
//

import SwiftUI
import Combine

struct CreateWorkspaceView: View {
    
    @StateObject private var model: CreateWorkSpaceModel
    private var intent: CreateWorkspaceIntent
    
    var onCreate: () -> Void = {}
    
    init(onCreate: @escaping () -> Void = {}) {
        _model = StateObject(wrappedValue: CreateWorkSpaceModel())
        self.intent = CreateWorkspaceIntent()
        self.onCreate = onCreate
    }
    
    var body: some View {
        VStack(spacing: 24) {
            
            ImageSelectButton(tapGesture: {})
            
            InputFieldCell(text: $model.workspaceName,
                           title: "워크스페이스 이름",
                           placeholder: "워크스페이스 이름을 입력하세요 (필수)")
            InputFieldCell(text: $model.workspaceDescription,
                           title: "워크스페이스 설명",
                           placeholder: "워크스페이스를 설명하세요 (옵션)")
            
            Spacer()
            
            BasicLargeButtonCell(title: "완료", isEnabled: model.isCreateAbled) {
                print(model.workspaceName)
                intent.createWorkspace() 
            }
            .padding()
            .disabled(!model.isCreateAbled)
        }
        .padding(.top, 32)
        .onAppear {
            intent.setModel(model)
        }
        .onTapGesture {
            endTextEditing()
        }
    }
}

#Preview {
    CreateWorkspaceView()
}
