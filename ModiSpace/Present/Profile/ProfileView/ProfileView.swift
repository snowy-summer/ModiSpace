//
//  ProfileView.swift
//  ModiSpace
//
//  Created by 전준영 on 11/12/24.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var nickname = "옹골찬 고래밥"
    @State private var phoneNumber = "010-1234-1234"
    @State private var email = "sesac@sesac.com"
    @State private var sesacCoin = 130
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                // 프로필 이미지 및 수정 버튼
                VStack {
                    ZStack {
                        Image("profileImage")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .background(Color.yellow)
                        
                        Image(systemName: "camera.fill")
                            .foregroundColor(.white)
                            .padding(6)
                            .background(Color.green)
                            .clipShape(Circle())
                            .offset(x: 30, y: 30)
                    }
                }
                .padding(.top, 20)
                
                // 첫 번째 섹션: 새싹 코인, 닉네임, 연락처
                VStack(spacing: 8) {
                    coinInfoView
                    
                    CustomNavigationRow(destination: NicknameEditView()) {
                        Text("닉네임")
                        Text(nickname)
                            .foregroundColor(.gray)
                    }
                    
                    CustomNavigationRow(destination: PhoneEditView()) {
                        Text("연락처")
                        Text(phoneNumber)
                            .foregroundColor(.gray)
                    }
                }
                .background(Color.white)
                .cornerRadius(12)
                .padding(.horizontal)
                
                // 두 번째 섹션: 이메일, 소셜 계정, 로그아웃
                VStack(spacing: 16) {
                    infoRow(title: "이메일", value: email)
                    socialAccountRow
                    logoutButton
                }
                .background(Color.white)
                .cornerRadius(12)
                .padding(.horizontal)
                
                Spacer()
            }
            .background(Color(.systemGray6))
            .navigationBarTitle("내 정보 수정", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                // 뒤로 가기 액션
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
            })
        }
    }
    
    // 새싹 코인 정보 뷰
    private var coinInfoView: some View {
        HStack {
            Text("내 새싹 코인")
            Spacer()
            Text("\(sesacCoin)")
                .foregroundColor(.green)
            Button("충전하기") {
                // 충전하기 액션
            }
            .foregroundColor(.gray)
        }
        .padding()
    }
    
    // 기본 정보 표시 뷰
    private func infoRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
                .foregroundColor(.gray)
        }
        .padding()
    }
    
    // 소셜 계정 뷰
    private var socialAccountRow: some View {
        HStack {
            Text("연결된 소셜 계정")
            Spacer()
            HStack(spacing: 8) {
                Image(systemName: "applelogo")
                Image(systemName: "bubble.left.and.bubble.right.fill")
            }
        }
        .padding()
    }
    
    // 로그아웃 버튼 뷰
    private var logoutButton: some View {
        Button(action: {
            // 로그아웃 액션
        }) {
            HStack {
                Text("로그아웃")
                    .foregroundColor(.red)
                Spacer()
            }
        }
        .padding()
    }
}
