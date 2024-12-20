//
//  CreateWorkspaceView.swift
//  ModiSpace
//
//  Created by 최승범 on 10/26/24.
//

import SwiftUI
import Combine

struct CreateWorkspaceView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var workspaceModel: WorkspaceModel
    @StateObject private var model: CreateWorkSpaceModel
    
    init() {
        _model = StateObject(wrappedValue: CreateWorkSpaceModel())
    }
    
    init(workspace: WorkspaceState) {
        _model = StateObject(wrappedValue: CreateWorkSpaceModel(workspace: workspace,
                                                                isEditingMode: true))
    }
    
    var body: some View {
        VStack(spacing: 24) {
            ImageSelectButton(action: {
                model.apply(.showImagePicker)
            }, image: model.workspaceImage.last)
            .sheet(isPresented: $model.isShowingImagePicker) {
                PhotoPicker(selectedImages: $model.workspaceImage,
                            isMultipleImage: false)
            }
            
            InputField(text: $model.workspaceName,
                       title: "워크스페이스 이름",
                       placeholder: "워크스페이스 이름을 입력하세요 (필수)")
            
            InputField(text: $model.workspaceDescription,
                       title: "워크스페이스 설명",
                       placeholder: "워크스페이스를 설명하세요 (옵션)")
            
            Spacer()
            
            CommonButton(icon: nil,
                         backgroundColor: .main,
                         text: "완료",
                         textColor: .white,
                         symbolColor: nil,
                         cornerRadius: 8,
                         isEnabled: model.isCreateAbled) {
                if model.isEditingMode {
                    model.apply(.editWorkspace)
                } else {
                    model.apply(.createWorkspace)
                }
                
                dismiss()
            }
             .padding()
             .disabled(!model.isCreateAbled)
        }
        .padding(.top, 32)
        .onTapGesture {
            endTextEditing()
        }
    }
    
}

//#Preview {
//    CreateWorkspaceView()
//}
