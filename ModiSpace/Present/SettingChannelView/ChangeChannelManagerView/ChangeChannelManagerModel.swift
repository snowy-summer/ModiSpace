//
//  ChangeChannelManagerModel.swift
//  ModiSpace
//
//  Created by 최승범 on 11/15/24.
//

import Foundation
import Combine

final class ChangeChannelManagerModel: ObservableObject {
    
    @Published var memberList = [OtherUserDTO]()
    var workspaceID: String = WorkspaceIDManager.shared.workspaceID ?? ""
    let channelID: String
    var isAble: Bool = true
    var selectedMember: OtherUserDTO?
    
    @Published var isShowAlert = false
    @Published var isExpiredRefreshToken = false
    
    init(channelID: String) {
        self.channelID = channelID
    }
    
    private let networkManager = NetworkManager()
    private var cancelable = Set<AnyCancellable>()

    func apply(_ intent: ChangeChannelManagerInent) {
        
        switch intent {
        case .fetchMemberList:
            fetchMemberList()
            
        case .expiredRefreshToken:
            isExpiredRefreshToken = true
            
        case .changeManager:
            changeManager()
            isShowAlert = false
            
        case .showAlert:
            isShowAlert = true
            
        case .dontShowAlert:
            isShowAlert = false
            
        case .selectMember(let member):
            selectedMember = member
        }
    }
    
}

//MARK: - 직접적인 변경 메서드
extension ChangeChannelManagerModel {
    
    private func fetchMemberList() {
        
        let router = ChannelRouter.getChannelMember(workspaceID: workspaceID,
                                                    channelID: channelID)
        
        networkManager.getDecodedDataWithPublisher(from: router,
                                                   type: [OtherUserDTO].self)
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
            self?.memberList = value
        }.store(in: &cancelable)
        
    }

    private func changeManager() {
        
        guard let member = selectedMember else { return }
        Task {
            do {
                let router = ChannelRouter.channelOwnershipTransfer(workspaceID: workspaceID,
                                                                    channelID: channelID,
                                                                    body: OwnershipTransferRequestBody(ownerID: member.userID))
                
                let _ = try await networkManager.getData(from: router)
                print("변경")
            } catch(let error) {
                print(error.localizedDescription)
            }
        }
    }
    
}
