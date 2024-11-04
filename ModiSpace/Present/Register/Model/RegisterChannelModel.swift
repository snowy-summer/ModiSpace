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
    var isRegistAble: Bool {
        !channelName.isEmpty
    }
    
    private let networkManager = NetworkManager()
    private var cancelable = Set<AnyCancellable>()
    
    func apply(_ intent: RegisterChannelIntent) {
        switch intent {
        case .registChannel(let fetch):
            regist(with: fetch)
        }
    }
    
    func regist(with fetch: @escaping () -> Void) {
        
        let channelBody = PostChannelRequestBody(name: channelName,
                                                 description: nil,
                                                 image: Data())
        
        networkManager.getDecodedDataWithPublisher(from: ChannelRouter.postChannel(workspaceID: workspaceID,
                                                                                   body: channelBody),
                                                   type: ChannelDTO.self)
        .sink(receiveCompletion: { completion in
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
        }, receiveValue: { value in
            fetch()
        }).store(in: &cancelable)
    }
}
