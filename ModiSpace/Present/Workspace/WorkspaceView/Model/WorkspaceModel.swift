//
//  WorkspaceModel.swift
//  ModiSpace
//
//  Created by 최승범 on 11/1/24.
//

import Foundation
import Combine

final class WorkspaceModel: ObservableObject {
    
    @Published var isShowChannels = false
    @Published var isShowMessageList = false
    @Published var isShowNewMessageView = false
    @Published var isShowSideView = false
    @Published var isShowMemberAddView = false
    @Published var isShowChannelAddView = false
    @Published var workspaceList: [WorkspaceDTO] = []
    
    var selectedWorkspace: WorkspaceDTO? {
        if workspaceList.isEmpty {
            return nil
        } else {
            WorkspaceIDManager.shared.workspaceID = workspaceList[0].workspaceID
            return workspaceList[0]
        }
    }
    
    private let networkManager = NetworkManager()
    private var cancelable = Set<AnyCancellable>()
    
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
            var list = value
            if !list.isEmpty {
                self?.workspaceList = list
            }
        }.store(in: &cancelable)
    }
    
}
