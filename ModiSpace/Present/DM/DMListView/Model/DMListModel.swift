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
    @Published var createMember = DMSDTO()
    @Published var dmsList = [DMSDTO]()
    @Published var dmsLastMessage = [DMSChatDTO]()
    @Published var unReadCount = [DMSUnreadCountDTO]()
    @Published var isShowChattingView = false
    @Published var isExpiredRefreshToken = false
    @Published var isShowProfileView = false
    
    private var cancelable = Set<AnyCancellable>()
    private let networkManager = NetworkManager()
    private let dbManager = DBManager()
    
    func apply(_ intent: DMListIntent) {
        switch intent {
        case .viewAppear:
            fetchGetMember()
            fetchListAndUnread()
            
        case .expiredRefreshToken:
            isExpiredRefreshToken = true
            
        case .creatRoom(let opponentID):
            creatRoom(opponentID)
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
                let publishers = dmsList.map { dm -> AnyPublisher<DMSUnreadCountDTO, Error> in
                    let lastMessageTime = self.fetchDBChattingLog(dms: dm)?.createdAt
                    return self.networkManager.getDecodedDataWithPublisher(
                        from: DMSRouter.unReadChatDMS(workspaceID: id,
                                                      roomID: dm.roomID,
                                                      after: lastMessageTime),
                        type: DMSUnreadCountDTO.self
                    )
                }
                return Publishers.MergeMany(publishers).collect().eraseToAnyPublisher()
            }

        
        let lastMessagesPublisher = dmListPublisher
            .flatMap { dmsList -> AnyPublisher<[DMSChatDTO], Error> in
                let publishers = dmsList.map { dm in
                    self.networkManager.getDecodedDataWithPublisher(
                        from: DMSRouter.getChatListDMS(workspaceID: id,
                                                       roomID: dm.roomID,
                                                       cursorDate: nil),
                        type: [DMSChatDTO].self
                    )
                    .map { $0.last }
                    .compactMap { $0 }
                    .eraseToAnyPublisher()
                }
                return Publishers.MergeMany(publishers).collect().eraseToAnyPublisher()
            }
        
        Publishers.Zip3(dmListPublisher, unreadCountsPublisher, lastMessagesPublisher)
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
            } receiveValue: { [weak self] dmsList, unreadCount, lastMessage in
                print("dmList: \(dmsList), unread: \(unreadCount), lastMessage: \(lastMessage)")
                self?.dmsList = dmsList
                self?.unReadCount = unreadCount
                self?.dmsLastMessage = lastMessage
            }
            .store(in: &cancelable)
    }
    
    private func creatRoom(_ opponentID: String) {
        guard let id = workspaceID else {
            print("No workspaceID")
            return
        }
        
        let dmListPublisher = networkManager.getDecodedDataWithPublisher(
            from: DMSRouter.createDMS(workspaceID: id,
                                      body: CreateDMSRequestBody(opponentID: opponentID)),
            type: DMSDTO.self
        )
        
        dmListPublisher
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
                self?.isShowChattingView = true
                self?.createMember = value
            }.store(in: &cancelable)
    }
    
    private func fetchLastMessageTime(for roomID: String) -> String? {
        let dbManager = DBManager()
        let lastChat = dbManager.fetchItems(ofType: DMChatList.self)
            .filter { $0.roomID == roomID }
            .sorted { $0.createdAt < $1.createdAt }
            .last
        
        return lastChat?.createdAt
    }
    
    private func fetchDBChattingLog(dms: DMSDTO) -> DMChatList? {
        let chatList = dbManager.fetchItems(ofType: DMChatList.self)
        
        var dmsChatList = chatList.filter {
            $0.roomID == dms.roomID
        } .sorted {
            $0.createdAt < $1.createdAt
        }
        
        return dmsChatList.last
    }
    
}
