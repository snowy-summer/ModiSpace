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
//                    model.apply(.showImagePicker)
                }, image: UIImage(named: "tempImage"))
//                .sheet(isPresented: $model.isShowingImagePicker) {
//                    PhotoPicker(selectedImages: $model.workspaceImage,
//                                isMultipleImage: false)
//                }
                
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
        }
        .onAppear {
            model.apply(.viewAppear)
        }
    }
    
}
