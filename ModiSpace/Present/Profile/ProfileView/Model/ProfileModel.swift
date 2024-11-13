//
//  ProfileModel.swift
//  ModiSpace
//
//  Created by 전준영 on 11/12/24.
//

import Foundation
import Combine

final class ProfileModel: ObservableObject {
    
    @Published var userData: UserProfileDTO?
    @Published var nickname: String = ""
    @Published var phoneNumber: String = ""
    @Published var providerName: String = ""
    
    private var cancelable = Set<AnyCancellable>()
    private let networkManager = NetworkManager()
    
    func apply(_ intent: ProfileIntent) {
        switch intent {
        case .viewAppear:
            fetchUserProfile()
        case .nickname(let nickname, let isEdit):
            self.nickname = nickname
            editProfile(isEditingNickname: isEdit)
        case .phone(let phone, let isEdit):
            self.phoneNumber = phone
            editProfile(isEditingNickname: isEdit)
        }
    }
    
}

extension ProfileModel {
    
    private func fetchUserProfile() {
        networkManager.getDecodedDataWithPublisher(from: UserRouter.getMyProfile,
                                                   type: UserProfileDTO.self)
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
        } receiveValue: { [weak self] response in
            print(response)
            self?.userData = response
            self?.nickname = response.nickname
            self?.phoneNumber = response.phone ?? ""
            self?.providerName = self?.getProviderImageName(response.provider) ?? ""
        }
        .store(in: &cancelable)
    }
    
    private func editProfile(isEditingNickname: Bool) {
        let editMyProfileBody: EditMyProfileRequestBody
        
        if isEditingNickname {
            editMyProfileBody = EditMyProfileRequestBody(nickname: nickname, phone: nil)
        } else {
            editMyProfileBody = EditMyProfileRequestBody(nickname: nil, phone: phoneNumber)
        }
        
        networkManager.getDecodedDataWithPublisher(from: UserRouter.updateMyProfile(body: editMyProfileBody),
                                                   type: UserProfileDTO.self)
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
        } receiveValue: { [weak self] response in
            print(response)
            self?.userData = response
            self?.nickname = response.nickname
            self?.phoneNumber = response.phone ?? ""
        }
        .store(in: &cancelable)
    }
    
}

extension ProfileModel {
    
    private func getProviderImageName(_ provider: String?) -> String {
        
        guard let provider = provider else { return "" }
        switch provider.lowercased() {
        case "kakao":
            return "kakaoLogin"
        case "apple":
            return "appleIDLogin"
        default:
            return ""
        }
        
    }
    
}
