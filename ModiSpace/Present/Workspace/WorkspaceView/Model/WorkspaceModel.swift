//
//  WorkspaceModel.swift
//  ModiSpace
//
//  Created by 최승범 on 11/1/24.
//

import SwiftUI
import Combine
import SwiftData

final class WorkspaceModel: ObservableObject {
    
    @Published var isShowNewMessageView = false
    @Published var isShowSideView = false
    @Published var isShowDeleteAlertView = false
    @Published var isShowProfileView = false
    @Published var isExpiredRefreshToken = false
    
    @Published var workspaceList: [WorkspaceState] = []
    @Published var selectedWorkspaceID: String? = WorkspaceIDManager.shared.workspaceID
    @Published var selectedWorkspaceChannelList = [ChannelDTO]()
    
    @Published var profileImage: UIImage? = nil
    @Published var sheetType: WorkspaceViewSheetType?
    
    var selectedWorkspace: WorkspaceState? {
        for workspace in workspaceList {
            if workspace.workspaceID == selectedWorkspaceID {
                return workspace
            }
        }
        
        if !isWorkspaceEmpty {
            WorkspaceIDManager.shared.workspaceID = workspaceList.first!.workspaceID
            return workspaceList.first!
        }
        
        return nil
    }
    
    var isWorkspaceEmpty: Bool {
        workspaceList.isEmpty
    }
    
    private let networkManager = NetworkManager()
    private let dateManager = DateManager()
    private let dbManager = DBManager()
    private var cancelable = Set<AnyCancellable>()
    
    init() {
        binding()
    }
    
    func apply(_ intent: WorkspaceIntent) {
        
        switch intent {
        case .insertModelContext(let context):
            dbManager.modelContext = context
            
        case .fetchWorkspaceList:
            fetchWorkspace()
            
        case .expiredRefreshToken:
            isExpiredRefreshToken = true
            
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
            
        case .exitWorkspace:
            exitWorkspace()
            
        case .profileMe:
            fetchUserProfile()
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
        .sink { [weak self] completion in
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
                        self?.apply(.expiredRefreshToken)
                    }
                }
                print(error.localizedDescription)
            }
        } receiveValue: { [weak self] value in
            self?.convertWorkspaceList(from: value)
            WorkspaceIDManager.shared.workspaceID = value.first?.workspaceID
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
        let router = ChannelRouter.myChannelList(workspaceID: id)
        networkManager.getDecodedDataWithPublisher(from: router,
                                                   type: [ChannelDTO].self)
        .receive(on: DispatchQueue.main)
        .sink { [weak self] completion in
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
                        self?.apply(.expiredRefreshToken)
                    }
                }
                print(error.localizedDescription)
            }
        } receiveValue: { [weak self] value in
            Task { [weak self] in
                guard let self = self else { return }
                var list = value
                
                await withTaskGroup(of: (Int, Int).self) { group in
                    for (index, channel) in list.enumerated() {
                        group.addTask {
                            let count = await self.fetchUnreadChatCount(channel: channel)
                            return (index, count)
                        }
                    }
                    
                    for await (index, count) in group {
                        if count != 0 {
                            list[index].unreadChannelCount = count
                        }
                    }
                }
                
                selectedWorkspaceChannelList = list
            }
        }
        .store(in: &cancelable)
        
    }
    
    private func fetchUnreadChatCount(channel: ChannelDTO) async -> Int {
        guard let id = selectedWorkspaceID else { return 0 }
        var chattingList = dbManager.fetchItems(ofType: ChannelChatList.self).filter { channel.channelID == $0.channelID }
        chattingList.sort { $0.createdAt < $1.createdAt }
        
        let router: ChannelRouter
        if let lastChat = chattingList.last {
            router = ChannelRouter.unReadCountChat(workspaceID: id,
                                                   channelID: channel.channelID,
                                                   after: lastChat.createdAt)
        } else {
            router = ChannelRouter.unReadCountChat(workspaceID: id,
                                                   channelID: channel.channelID,
                                                   after: "2024-10-18T09:30:00.722Z")
        }
        
        do {
            let count = try await networkManager.getDecodedData(from: router,
                                                                type: UnReadChannelCountDTO.self).count
            return count
        } catch {
            print(error)
            return 0
        }
    }
    
    private func deleteWorkspace() {
        networkManager.getDataWithPublisher(from: WorkSpaceRouter.deleteWorkSpace(spaceId: selectedWorkspaceID ?? ""))
            .sink { [weak self] completion in
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
                            self?.apply(.expiredRefreshToken)
                        }
                    }
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] data in
                self?.fetchWorkspace()
            }
            .store(in: &cancelable)
        
    }
    
    private func exitWorkspace() {
        guard let id = selectedWorkspaceID else { return }
        networkManager.getDataWithPublisher(from: WorkSpaceRouter.exitWorkSpace(spaceId: id))
            .sink { [weak self] completion in
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
                            self?.apply(.expiredRefreshToken)
                        }
                    }
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] data in
                self?.fetchWorkspace()
            }
            .store(in: &cancelable)
    }
    
    private func fetchUserProfile() {
        networkManager.getDecodedDataWithPublisher(from: UserRouter.getMyProfile, type: UserProfileDTO.self)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print("프로필 데이터 가져오기 실패: \(error)")
                }
            } receiveValue: { [weak self] response in
                Task { [weak self] in
                    guard let self = self else { return }
                    if let image = await self.fetchImage(for: response.profileImage ?? "") {
                        DispatchQueue.main.async {
                            self.profileImage = image
                        }
                    }
                }
            }
            .store(in: &cancelable)
    }
}
