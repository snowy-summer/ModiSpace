//
//  RegisterChannelModel.swift
//  ModiSpace
//
//  Created by 최승범 on 11/4/24.
//

import Foundation
import Combine

final class RegisterChannelModel: ObservableObject {
    
    @Published var workspaceID = WorkspaceIDManager.shared.workspaceID ?? ""
    @Published var channelName: String = ""
    @Published var channelDescription: String = ""
    
    @Published var isExpiredRefreshToken: Bool = false
    
    var isRegistAble: Bool {
        !channelName.isEmpty
    }
    
    private let networkManager = NetworkManager()
    private var cancelable = Set<AnyCancellable>()
    
    func apply(_ intent: RegisterChannelIntent) {
        switch intent {
        case .expiredRefreshToken:
            isExpiredRefreshToken = true
            
        case .registChannel:
            regist()
        }
    }
    
    func regist() {
        
        let channelBody = PostChannelRequestBody(name: channelName,
                                                 description: channelDescription,
                                                 image: Data())
        
        networkManager.getDecodedDataWithPublisher(from: ChannelRouter.postChannel(workspaceID: workspaceID,
                                                                                   body: channelBody),
                                                   type: ChannelDTO.self)
        .sink(receiveCompletion: { [weak self] completion in
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
        }, receiveValue: { _ in
        }).store(in: &cancelable)
    }
}
