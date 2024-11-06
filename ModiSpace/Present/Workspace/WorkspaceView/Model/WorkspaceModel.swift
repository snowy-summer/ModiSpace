//
//  WorkspaceModel.swift
//  ModiSpace
//
//  Created by 최승범 on 11/1/24.
//

import SwiftUI
import Combine

final class WorkspaceModel: ObservableObject {
    
    @Published var isShowNewMessageView = false
    @Published var isShowSideView = false
    @Published var isShowDeleteAlertView = false
    
    @Published var workspaceList: [WorkspaceState] = []
    @Published var selectedWorkspaceID: String? = WorkspaceIDManager.shared.workspaceID
    @Published var selectedWorkspaceChannelList = [ChannelDTO]()
    
    @Published var sheetType: WorkspaceViewSheetType?
    
    var selectedWorkspace: WorkspaceState? {
        for workspace in workspaceList {
            if workspace.workspaceID == selectedWorkspaceID {
                return workspace
            }
        }
        return nil
    }
    
    var isWorkspaceEmpty: Bool {
        workspaceList.isEmpty
    }
    
    private let networkManager = NetworkManager()
    private let dateManager = DateManager()
    private var cancelable = Set<AnyCancellable>()
    
    init() {
        binding()
    }
    
    func apply(_ intent: WorkspaceIntent) {
        
        switch intent {
            
        case .viewAppear:
            fetchWorkspace()
            
        case .showSideView:
            isShowSideView = true
            
        case .dontShowSideView:
            isShowSideView = false
            
        case .showMemberAddView:
            sheetType = .addMemberView
            
        case .showEditWorkspaceView(let workspace):
            sheetType = .editWorkspace(workspace)
            
        case .showCreateWorkspaceView:
            sheetType = .createWorkspace
            
        case .showChangeManagerView:
            sheetType = .changeWorkspaceManager
            
        case .reloadChannelList:
            fetchChannelList()
            
        case .showDeleteAlert:
            isShowDeleteAlertView = true
            
        case .dontShowDeleteAlert:
            isShowDeleteAlertView = false
            
        case .deleteWorkspace:
            isShowDeleteAlertView = false
            isShowSideView = false
            deleteWorkspace()
            
        case .reloadWorkspaceList:
            fetchWorkspace()
        }
    }
    
}

extension WorkspaceModel {
    
    private func binding() {
        WorkspaceIDManager.shared.$workspaceID
            .sink { [weak self] newID in
                self?.selectedWorkspaceID = newID
                self?.fetchChannelList()
            }
            .store(in: &cancelable)
    }
    
    private func fetchWorkspace() {
        
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
                    createdAt: dateManager.convertToFormattedString(isoString: dto.createdAt,
                                                                    format: "yyyy. MM. dd") ?? "",
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
    
    private func fetchChannelList() {
        guard let id = selectedWorkspaceID else { return }
        networkManager.getDecodedDataWithPublisher(from: WorkSpaceRouter.getWorkSpaceInfo(spaceId: id),
                                                   type: WorkspaceDTO.self)
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
            self?.selectedWorkspaceChannelList = value.channels
        }.store(in: &cancelable)
        
    }
    
    private func deleteWorkspace() {
        networkManager.getDataWithPublisher(from: WorkSpaceRouter.deleteWorkSpace(spaceId: selectedWorkspaceID ?? ""))
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
            } receiveValue: { [weak self] data in
                self?.fetchWorkspace()
            }
            .store(in: &cancelable)
        
    }
}
