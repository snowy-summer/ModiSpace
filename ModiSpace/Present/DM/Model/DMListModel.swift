//
//  DMListModel.swift
//  ModiSpace
//
//  Created by 전준영 on 11/11/24.
//

import Foundation
import Combine

final class DMListModel: ObservableObject {
    
    @Published var workspaceID: String? = WorkspaceIDManager.shared.workspaceID
    @Published var workspaceMemberList = [WorkspaceMemberDTO]()
    @Published var dmsList = [DMSDTO]()
    @Published var unReadCount = [DMSUnreadCountDTO]()
    
    @Published var isExpiredRefreshToken = false
    
    private var cancelable = Set<AnyCancellable>()
    private let networkManager = NetworkManager()
    
    func apply(_ intent: DMListIntent) {
        switch intent {
        case .viewAppear:
            fetchGetMember()
            fetchListAndUnread()
            
        case .expiredRefreshToken:
            isExpiredRefreshToken = true
        }
    }
    
}

extension DMListModel {
    
    private func fetchGetMember() {
        guard let id = workspaceID else {
            print("No workspaceID")
            return
        }
        networkManager.getDecodedDataWithPublisher(from: WorkSpaceRouter.getMemberList(spaceId: id),
                                                   type: [WorkspaceMemberDTO].self)
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
            print(value)
            self?.workspaceMemberList = value
        }.store(in: &cancelable)
    }
    
    private func fetchListAndUnread() {
        guard let id = workspaceID else {
            print("No workspaceID")
            return
        }
        
        let dmListPublisher = networkManager.getDecodedDataWithPublisher(
            from: DMSRouter.getListDMS(workspaceID: id),
            type: [DMSDTO].self
        )
        
        let unreadCountsPublisher = dmListPublisher
            .flatMap { dmsList -> AnyPublisher<[DMSUnreadCountDTO], Error> in
                let publishers = dmsList.map { dm in
                    self.networkManager.getDecodedDataWithPublisher(
                        from: DMSRouter.unReadChatDMS(workspaceID: id,
                                                      roomID: dm.roomID,
                                                      after: nil),
                        type: DMSUnreadCountDTO.self
                    )
                }
                return Publishers.MergeMany(publishers).collect().eraseToAnyPublisher()
            }
        
        Publishers.Zip(dmListPublisher, unreadCountsPublisher)
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
                            self?.apply(.expiredRefreshToken)
                            print("리프레시 토큰 만료")
                        }
                    }
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] dmsList, unreadCount in
                print("dmList: \(dmsList), unread: \(unreadCount)")
                self?.dmsList = dmsList
                self?.unReadCount = unreadCount
            }
            .store(in: &cancelable)
    }
    
}
