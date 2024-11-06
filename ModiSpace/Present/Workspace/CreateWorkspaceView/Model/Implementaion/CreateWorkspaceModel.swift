//
//  CreateWorkspaceModel.swift
//  ModiSpace
//
//  Created by 최승범 on 10/26/24.
//

import SwiftUI

final class CreateWorkSpaceModel: ObservableObject {
    
    @Published var workspaceImage = [UIImage]()
    @Published var workspaceName = ""
    @Published var workspaceDescription = ""
    var workspaceID: String = ""
    @Published var isShowingImagePicker = false
    var isEditingMode = false
    
    init(workspace: WorkspaceState = WorkspaceState(),
         isShowingImagePicker: Bool = false,
         isEditingMode: Bool = false) {
        self.workspaceImage = [workspace.coverImage]
        self.workspaceName = workspace.name
        self.workspaceDescription = workspace.description
        self.workspaceID = workspace.workspaceID
        self.isEditingMode = isEditingMode
        self.isShowingImagePicker = isShowingImagePicker
    }
    
    var isCreateAbled: Bool {
        !workspaceName.isEmpty
    }
    
    func apply(_ intent: CreateWorkspaceIntent) {
        
        switch intent {
        case .createWorkspace:
            createWorkspace()
            
        case .editWorkspace:
            editingWorkspace()
            
        case .updateName(let name):
            updateWorkspaceName(name)
            
        case .updateImage(let image):
            updateWorkspaceImage(image)
            
        case .updateDescription(let text):
            updateWorkspaceDescription(text)
            
        case .showImagePicker:
            isShowingImagePicker = true
        }
    }
    
}

//MARK: - 직접적인 변경 메서드
extension CreateWorkSpaceModel {
    
    private func updateWorkspaceName(_ name: String) {
        workspaceName = name
    }
    
    private func updateWorkspaceDescription(_ description: String) {
        workspaceDescription = description
    }
    
    private func updateWorkspaceImage(_ image: UIImage) {
        workspaceImage = [image]
    }
    
    private func createWorkspace() {
        Task {
            do {
                guard let imageData = workspaceImage.last?.jpegData(compressionQuality: 0.4) else { return }
                let router = WorkSpaceRouter.createWorkSpace(body: WorkspaceRequestBody(name: workspaceName,
                                                                                        description: workspaceDescription,
                                                                                        image: imageData))
                let response = try await NetworkManager().getDecodedData(from: router,
                                                                         type: WorkspaceDTO.self)
            } catch(let error) {
                print(error.localizedDescription)
            }
        }
    }
    
    private func editingWorkspace() {
        Task {
            do {
                guard let imageData = workspaceImage.last?.jpegData(compressionQuality: 0.4) else { return }
                let router = WorkSpaceRouter.editWorkSpace(spaceId: workspaceID,
                                                           body: WorkspaceRequestBody(name: workspaceName,
                                                                                      description: workspaceDescription,
                                                                                      image: imageData))
                let response = try await NetworkManager().getDecodedData(from: router,
                                                                         type: WorkspaceDTO.self)
            } catch(let error) {
                print(error.localizedDescription)
            }
        }
    }
    
}
