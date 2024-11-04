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
    @Published var isShowingImagePicker = false
    
    init(workspaceImage: [UIImage] = [UIImage](),
         workspaceName: String = "",
         workspaceDescription: String = "",
         isShowingImagePicker: Bool = false) {
        self.workspaceImage = workspaceImage
        self.workspaceName = workspaceName
        self.workspaceDescription = workspaceDescription
        self.isShowingImagePicker = isShowingImagePicker
    }
    
    var isCreateAbled: Bool {
        !workspaceName.isEmpty
    }
    
    func apply(_ intent: CreateWorkspaceIntent) {
        
        switch intent {
        case .createWorkspace:
            createWorkspace()
            
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
                guard let imageData = workspaceImage.first?.jpegData(compressionQuality: 0.4) else { return }
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
    
}
