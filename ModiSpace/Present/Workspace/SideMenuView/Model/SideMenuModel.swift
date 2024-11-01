//
//  SideMenuModel.swift
//  ModiSpace
//
//  Created by 최승범 on 11/1/24.
//

import Foundation
import Combine

final class SideMenuModel: ObservableObject {
    
    @Published var workspaceList: [WorkspaceDTO] = []
    @Published var isShowHelpGuide: Bool = false
    @Published var isShowMoreMenu: Bool = false
    @Published var isShowCreateWorkspaceView: Bool = false
    
    var isWorkspaceEmpty: Bool {
        workspaceList.isEmpty
    }
    
    private let networkManager = NetworkManager()
    private var cancelable = Set<AnyCancellable>()
    
    func apply(_ intent: SideMenuIntnet) {
        
        switch intent {
        case .fetchWorkspaceList:
            fetchWorkspaceList()
            
        case .changeWorkspace:
            isShowMoreMenu = true
            
        case .addWorkspace:
            isShowCreateWorkspaceView = true
            
        case .showHelpGuide:
            isShowHelpGuide = true
            
        case .showMoreMenu:
            isShowMoreMenu = true
        }
    }
}

extension SideMenuModel {
    
    private func fetchWorkspaceList() {
        
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
        } receiveValue: { [weak self] list in
            self?.workspaceList = list
        }.store(in: &cancelable)
        
    }
    
}
