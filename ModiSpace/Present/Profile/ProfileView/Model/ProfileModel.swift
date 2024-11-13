//
//  ProfileModel.swift
//  ModiSpace
//
//  Created by 전준영 on 11/12/24.
//

import SwiftUI
import Combine

@MainActor
final class ProfileModel: ObservableObject {
    
    @Published var userData: UserProfileDTO?
    @Published var nickname: String = ""
    @Published var phoneNumber: String = ""
    @Published var providerName: String = ""
    @Published var myProfileImage = [UIImage]()
    @Published var isShowingImagePicker = false
    @Published var isShowLogoutAlertView = false
    @Published var isUpdateSuccess = false
    @Published var goOnboarding = false
    
    private var cancelable = Set<AnyCancellable>()
    private let networkManager = NetworkManager()
    private var kakaoAuthVM = KakaoAuthVM()
    
    func apply(_ intent: ProfileIntent) {
        switch intent {
        case .viewAppear:
            fetchUserProfile()
            
        case .nickname(let nickname, let isEdit):
            self.nickname = nickname
            editProfile(isEditingNickname: isEdit) {
                self.isUpdateSuccess = true
            }
            
        case .phone(let phone, let isEdit):
            self.phoneNumber = phone
            editProfile(isEditingNickname: isEdit) {
                self.isUpdateSuccess = true
            }
            
        case .showImagePicker:
            isShowingImagePicker = true
            
        case .myProfileImageChange:
            updateProfileImage {
                print("프로필 이미지가 성공적으로 변경되었습니다.")
            }
            
        case .showLogoutAlertView:
            isShowLogoutAlertView = true
            
        case .dontShowLogoutAlert:
            isShowLogoutAlertView = false
            
        case .logout:
            logout()
            
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
            Task { [weak self] in
                guard let self = self else { return }
                if let profileImage = await self.fetchImage(for: response.profileImage ?? "") {
                    DispatchQueue.main.async {
                        self.myProfileImage = [profileImage]
                    }
                }
            }
        }
        .store(in: &cancelable)
    }
    
    private func editProfile(isEditingNickname: Bool,
                             onSuccess: @escaping () -> Void) {
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
            onSuccess()
        }
        .store(in: &cancelable)
    }
    
    private func updateProfileImage(onSuccess: @escaping () -> Void) {
        guard let imageData = myProfileImage.last?.jpegData(compressionQuality: 0.4) else { return }
        let updateProfileImageBody = UpdateMyProfileImageRequestBody(image: imageData)
        
        networkManager.getDecodedDataWithPublisher(from: UserRouter.updateMyProfileImage(body: updateProfileImageBody),
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
            onSuccess()
        }
        .store(in: &cancelable)
        
    }
    
    private func fetchImage(for path: String) async -> UIImage? {
        let router = ImageRouter.getImage(path: path)
        return await ImageCacheManager.shared.fetchImage(from: router)
    }
    
    private func logout() {
        networkManager.getDataWithPublisher(from: UserRouter.logout)
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
            } receiveValue: { [weak self] _ in
                guard let self = self else { return }
                
                guard let provider = self.userData?.provider else {
                    self.defaultLogout {
                        DispatchQueue.main.async {
                            self.goOnboarding = true
                        }
                    }
                    return
                }
                
                switch provider.lowercased() {
                case "kakao":
                    self.kakaoAuthVM.kakaoLogout {
                        DispatchQueue.main.async {
                            self.goOnboarding = true
                        }
                    }
                    
                case "apple":
                    self.appleLogout {
                        DispatchQueue.main.async {
                            self.goOnboarding = true
                        }
                    }
                    
                default:
                    self.defaultLogout {
                        DispatchQueue.main.async {
                            self.goOnboarding = true
                        }
                    }
                }
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
    
    private func defaultLogout(completion: @escaping () -> Void) {
        print("로컬아이디 로그아웃")
        completion()
    }
    
    private func appleLogout(completion: @escaping () -> Void) {
        print("애플 로그아웃")
        completion()
    }
    
}
