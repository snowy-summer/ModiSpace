//
//  ProfileView.swift
//  ModiSpace
//
//  Created by 전준영 on 11/12/24.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var model = ProfileModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                ImageSelectButton(action: {
                    model.apply(.showImagePicker)
                }, image: model.myProfileImage.last)
                .sheet(isPresented: $model.isShowingImagePicker,
                       onDismiss: handleImageSelection) {
                    PhotoPicker(selectedImages: $model.myProfileImage,
                                isMultipleImage: false)
                }
                .padding(.top)
                
                VStack(spacing: 4) {
                    SelectableRow(destination: ContentView(),
                                  showChevron: true) {
                        Text("내 새싹 코인")
                            .foregroundStyle(.black)
                            .customFont(.bodyBold)
                        
                        Text("\(model.userData?.sesacCoin ?? 0)")
                            .foregroundStyle(.green)
                            .customFont(.bodyBold)
                        
                        Spacer()
                        
                        Text("충전하기")
                            .foregroundStyle(.gray)
                            .customFont(.bodyBold)
                    }
                    
                    SelectableRow(destination: ProfileEditView(model: model,
                                                               isEditingNickname: true),
                                  showChevron: true) {
                        Text("닉네임")
                            .foregroundStyle(.black)
                            .customFont(.bodyBold)
                        
                        Spacer()
                        
                        Text(model.userData?.nickname ?? "닉네임 없음")
                            .foregroundStyle(.gray)
                            .customFont(.bodyBold)
                    }
                    
                    SelectableRow(destination: ProfileEditView(model: model,
                                                               isEditingNickname: false),
                                  showChevron: true) {
                        Text("연락처")
                            .foregroundStyle(.black)
                            .customFont(.bodyBold)
                        
                        Spacer()
                        
                        Text(model.userData?.phone ?? "연락처 없음")
                            .foregroundStyle(.gray)
                            .customFont(.bodyBold)
                    }
                }
                .background(.white)
                .cornerRadius(12)
                .padding(.horizontal)
                
                VStack(spacing: 4) {
                    SelectableRow<Never, _>(destination: nil,
                                            showChevron: false) {
                        Text("이메일")
                            .foregroundStyle(.black)
                            .customFont(.bodyBold)
                        
                        Spacer()
                        
                        Text(model.userData?.email ?? "이메일 없음")
                            .foregroundStyle(.gray)
                            .customFont(.bodyBold)
                    }
                    
                    SelectableRow<Never, _>(destination: nil,
                                            showChevron: false) {
                        Text("연결된 소셜 계정")
                            .foregroundStyle(.black)
                            .customFont(.bodyBold)
                        
                        Spacer()
                        
                        if !model.providerName.isEmpty {
                            Image(model.providerName)
                                .resizable()
                                .frame(width: 24, height: 24)
                        }
                    }
                    
                    SelectableRow<Never, _>(destination: nil,
                                            showChevron: false) {
                        Button(action: {
                            model.apply(.showLogoutAlertView)
                        }) {
                            HStack {
                                Text("로그아웃")
                                    .foregroundStyle(.black)
                                    .customFont(.bodyBold)
                                Spacer()
                            }
                        }
                        
                        Spacer()
                    }
                }
                .background(.white)
                .cornerRadius(12)
                .padding(.horizontal)
                
                Spacer()
            }
            .background(Color(.systemGray6))
            .navigationBarTitle("내 정보 수정", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.black)
            })
            .onReceive(model.$goOnboarding) { value in
                if value {
                    DispatchQueue.main.async {
                        setRootViewToOnboarding()
                    }
                }
            }
        }
        .overlay {
            if model.isShowLogoutAlertView {
                Rectangle()
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            model.apply(.logout)
                        }
                    }
                AlertView(
                    title: "로그아웃",
                    message: "정말 로그아웃 할까요?",
                    primaryButtonText: "취소",
                    secondaryButtonText: "로그아웃",
                    onPrimaryButtonTap: { model.apply(.dontShowLogoutAlert) },
                    onSecondaryButtonTap: { model.apply(.logout) }
                )
            }
        }
        .onAppear {
            model.apply(.viewAppear)
        }
        .onReceive(model.$goOnboarding) { value in
            if value {
                setRootViewToOnboarding()
            }
        }
        
    }
    
    private func setRootViewToOnboarding() {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        let rootViewController = UIHostingController(rootView: OnboardingView())
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
    
    private func handleImageSelection() {
        guard let newImage = model.myProfileImage.last else { return }
        if !areImagesEqual(model.previousImage, newImage) {
            model.apply(.myProfileImageChange)
        }
        model.previousImage = newImage
    }
    
    private func areImagesEqual(_ image1: UIImage?, _ image2: UIImage?) -> Bool {
        guard let image1 = image1, let image2 = image2 else {
            return image1 == nil && image2 == nil
        }
        return image1.pngData() == image2.pngData()
    }
    
}
