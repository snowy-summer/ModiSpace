//
//  ChangeManagerModel.swift
//  ModiSpace
//
//  Created by 최승범 on 11/6/24.
//

import Foundation
import Combine

final class ChangeManagerModel: ObservableObject {
    
    @Published var email = ""
    @Published var memberList = [WorkspaceMemberDTO]()
    var workspaceID: String = WorkspaceIDManager.shared.workspaceID ?? ""
    var isAble: Bool = true
    var selectedMember: WorkspaceMemberDTO?
    
    @Published var isShowAlert = false
    @Published var isExpiredRefreshToken = false
    
    private let networkManager = NetworkManager()
    private var cancelable = Set<AnyCancellable>()

    func apply(_ intent: ChangeManagerInent) {
        
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
            
        case .saveMember(let member):
            selectedMember = member
        }
    }
    
}

//MARK: - 직접적인 변경 메서드
extension ChangeManagerModel {
    
    private func fetchMemberList() {
        
        networkManager.getDecodedDataWithPublisher(from: WorkSpaceRouter.getMemberList(spaceId: workspaceID),
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
            self?.memberList = value
        }.store(in: &cancelable)
        
    }

    private func changeManager() {
        
        guard let member = selectedMember else { return }
        Task {
            do {
                let router = WorkSpaceRouter.changeWorkSpaceManager(spaceId: workspaceID,
                                                                    body: ChangeWorkspaceManagerRequestBody(owner_id: member.userID))
                
                let _ = try await networkManager.getData(from: router)
                print("초대")
            } catch(let error) {
                print(error.localizedDescription)
            }
        }
    }
    
}

