//
//  CategoryListModel.swift
//  ModiSpace
//
//  Created by 최승범 on 11/3/24.
//

import Foundation
import Combine

final class CategoryListModel: ObservableObject {
    
    @Published var workspaceID: String
    
    @Published var isShowChannels = false
    @Published var isShowMessageList = false
    @Published var isShowNewMessageView = false
    
    @Published var selectedDirect: String? = nil
    @Published var showActionSheet = false
    @Published var showAddChannelView = false
    @Published var newChannelTitle: String = ""
    
    @Published var channelList: [ChannelDTO] = []
    
    private let networkManager = NetworkManager()
    private var cancelable = Set<AnyCancellable>()
    
    init() {
        workspaceID = WorkspaceIDManager.shared.workspaceID ?? ""
        fetchChannelList()
    }
   
    func apply(_ intent: CategoryListIntent) {
        switch intent {
        case .viewAppear:
            fetchChannelList()
            return
            
        case .showAddChannelView:
            showAddChannelView = true
            
        case .changingShowedChannelState:
            isShowChannels.toggle()
            
        case .showActionSheet:
            showActionSheet = true
            
        case .reloadChannelList:
            fetchChannelList()
        }
    }
    
}

extension CategoryListModel {
    
    private func fetchChannelList() {
        if workspaceID.isEmpty { return }
        networkManager.getDecodedDataWithPublisher(from: WorkSpaceRouter.getWorkSpaceInfo(spaceId: workspaceID),
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
            self?.channelList = value.channels
        }.store(in: &cancelable)
        
    }
    
}
