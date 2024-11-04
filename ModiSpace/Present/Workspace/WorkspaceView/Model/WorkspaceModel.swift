//
//  WorkspaceModel.swift
//  ModiSpace
//
//  Created by 최승범 on 11/1/24.
//

import UIKit
import Combine

final class WorkspaceModel: ObservableObject {
    
    @Published var isShowChannels = false
    @Published var isShowMessageList = false
    @Published var isShowNewMessageView = false
    @Published var isShowSideView = false
    @Published var isShowMemberAddView = false
    @Published var isShowChannelAddView = false
    @Published var isShowEditWorkspaceView = false
    @Published var workspaceList: [WorkspaceState] = []
    @Published var selectedWorkspaceID: String? = WorkspaceIDManager.shared.workspaceID
    
    var selectedWorkspace: WorkspaceState? {
        for workspace in workspaceList {
            if workspace.workspaceID == selectedWorkspaceID {
                return workspace
            }
        }
        return nil
    }
    
    private let networkManager = NetworkManager()
    private var cancelable = Set<AnyCancellable>()
    
    init() {
        WorkspaceIDManager.shared.$workspaceID
                   .assign(to: &$selectedWorkspaceID)
    }
    
    func apply(_ intent: WorkspaceIntent) {
        
        switch intent {
        case .showChannels:
            isShowChannels = true
            
        case .showMessageList:
            isShowMessageList = true
            
        case .showNewMessageView:
            isShowNewMessageView = true
            
        case .showSideView:
            isShowSideView = true
            
        case .dontShowSideView:
            isShowSideView = false
            
        case .showMemberAddView:
            isShowMemberAddView = true
            
        case .showChannelAddView:
            isShowChannelAddView = true
            
        case .showEditWorkspaceView:
            isShowEditWorkspaceView = true
            
        }
    }
    
}

extension WorkspaceModel {

    func fetchWorkspace() {
        
        networkManager.getDecodedDataWithPublisher(from: WorkSpaceRouter.getWorkSpaceList,
                                                   type: [WorkspaceDTO].self)
        .receive(on: DispatchQueue.main)
        .sink { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                if let error = error as? NetworkError {
                    print(error.description)
                }
                if let error = error as? APIError {
                    if error == .refreshTokenExpired {
                        print("리프레시 토큰 만료")
                    }
                }
                print(error.localizedDescription)
            }
        } receiveValue: { [weak self] value in
            self?.convertWorkspaceList(from: value)
        }.store(in: &cancelable)
    }
    
    private func convertWorkspaceList(from dtoList: [WorkspaceDTO]) {
        Task {
            var workspaceStates: [WorkspaceState] = []
    
            for dto in dtoList {
                var workspaceState = WorkspaceState(
                    workspaceID: dto.workspaceID,
                    name: dto.name,
                    description: dto.description,
                    coverImageString: dto.coverImage,
                    ownerID: dto.ownerID,
                    createdAt: dto.createdAt,
                    channels: dto.channels,
                    workspaceMembers: dto.workspaceMembers
                )
                
                if let image = await fetchImage(for: dto.coverImage) {
                    workspaceState.coverImage = image
                }
                
                workspaceStates.append(workspaceState)
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.workspaceList = workspaceStates
            }
        }
    }
    
    private func fetchImage(for path: String) async -> UIImage? {
        let router = ImageRouter.getImage(path: path)
        return await ImageCacheManager.shared.fetchImage(from: router)
    }
    
}
