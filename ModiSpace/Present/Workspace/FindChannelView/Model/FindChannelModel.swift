//
//  FindChannelModel.swift
//  ModiSpace
//
//  Created by 최승범 on 11/8/24.
//

import Foundation
import Combine

final class FindChannelModel: ObservableObject {
    
    @Published var channelList: [ChannelDTO] = []
    
    @Published var isExpiredRefreshToken = false
    
    private let networkManager = NetworkManager()
    private var cancelable = Set<AnyCancellable>()
    
    func apply(_ intent: FindChannelIntent) {
        switch intent {
        case .fetchChannelList:
            fetchChannelList()
            
        case .expiredRefreshToken:
            isExpiredRefreshToken = true
            
        }
    }
    
}

extension FindChannelModel {
    
    private func fetchChannelList() {
        guard let id = WorkspaceIDManager.shared.workspaceID else { return }
        let router = ChannelRouter.getChannelList(workspaceID: id)
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
            self?.channelList = value
        }.store(in: &cancelable)
        
    }
}
