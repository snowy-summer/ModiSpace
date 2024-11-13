//
//  ProfileView.swift
//  ModiSpace
//
//  Created by 전준영 on 11/12/24.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var model = ProfileModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                ImageSelectButton(action: {
                    model.apply(.showImagePicker)
                }, image: model.myProfileImage.last)
                .sheet(isPresented: $model.isShowingImagePicker) {
                    PhotoPicker(selectedImages: $model.myProfileImage,
                                isMultipleImage: false)
                }
                .onChange(of: model.myProfileImage) { newImages in
                    if !newImages.isEmpty, let newImage = newImages.last {
                        print("이미지가 선택되었습니다.")
                        model.apply(.myProfileImageChange)
                    }
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
            .navigationBarItems(leading: Button(action: {
                
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
    
}
