//
//  DMListView.swift
//  ModiSpace
//
//  Created by 전준영 on 11/10/24.
//

import SwiftUI

struct DMMessage: Identifiable {
    let id = UUID()
    let profile: String
    let nickname: String
    let message: String
    let time: String
    let badgeCount: Int
}

struct DMListView: View {
    let messages: [DMMessage] = [
        DMMessage(profile: "tempImage",
                  nickname: "옹골찬 고래밥",
                  message: "오늘 정말 고생 많으셨습니다~!!",
                  time: "PM 11:23",
                  badgeCount: 8),
        DMMessage(profile: "tempImage",
                  nickname: "Hue",
                  message: "Cause I know what you like boy You're my chemical hype boy 내 지난날들은 눈 뜨면 잊는 꿈 Hype boy 너만원",
                  time: "PM 06:33",
                  badgeCount: 1),
        DMMessage(profile: "tempImage",
                  nickname: "미묘한도사",
                  message: "저희 수료식이 언제였죠?",
                  time: "AM 05:08",
                  badgeCount: 0),
        DMMessage(profile: "tempImage",
                  nickname: "캠퍼스좋아",
                  message: "이력서와 포트폴리오 파일입니다!",
                  time: "2024년 10월 20일",
                  badgeCount: 0),
        DMMessage(profile: "tempImage",
                  nickname: "고래밥",
                  message: "사진",
                  time: "2024년 10월 3일",
                  badgeCount: 4),
        DMMessage(profile: "tempImage",
                  nickname: "Jack",
                  message: "저희 수료식이 언제였죠?",
                  time: "2024년 9월 22일",
                  badgeCount: 0)
    ]
    
    let profiles: [(profile: String, nickname: String)] = [
        ("tempImage", "디비두밥"), ("tempImage", "고래밥"), ("tempImage", "카스타드"),
        ("tempImage", "Sam"), ("tempImage", "Bran"), ("tempImage", "Daisy")
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(profiles, id: \.nickname) { profile in
                            ProfileNickCell(profile: profile.profile,
                                            nickText: profile.nickname)
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.vertical, 12)
                
                List(messages) { message in
                    DMListCell(
                        profileImage: message.profile,
                        userNickname: message.nickname,
                        message: message.message,
                        time: message.time,
                        badgeCount: message.badgeCount
                    )
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                }
                .listStyle(PlainListStyle())
            }
        }
    }
}
