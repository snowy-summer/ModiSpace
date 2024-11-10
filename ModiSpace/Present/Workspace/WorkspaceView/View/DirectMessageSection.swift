//
//  DirectMessageSection.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/29/24.
//

//import SwiftUI
//
//struct DirectMessageSection: View {
//    
//    @Binding var isDirectShow: Bool
//    @Binding var showNewMessageView: Bool
//    
//    let directMessages: [String]
//    
//    var body: some View {
//        VStack {
//            Button(action: {
//                isDirectShow.toggle()
//            }) {
//                HStack {
//                    Text("다이렉트 메시지")
//                        .font(.headline)
//                        .foregroundStyle(.black)
//                    
//                    Spacer()
//                    
//                    Image(systemName: isDirectShow ? "chevron.down" : "chevron.forward")
//                        .foregroundStyle(.black)
//                }
//                .padding()
//            }
//            
//            if isDirectShow {
//                VStack(alignment: .leading) {
//                    ForEach(directMessages, id: \.self) { name in
//                        NavigationLink(
//                            destination: ChattingView(channel: name),
//                            label: {
//                                DirectMessageCell(directTitle: name,
//                                               icon: "star")
//                                    .foregroundStyle(.gray)
//                            }
//                        )
//                    }
//                    
//                    SFSubButton(text: "새 메시지 시작") {
//                        showNewMessageView = true
//                    }
//                    .padding()
//                }
//                .transition(.slide)
//            }
//        }
//    }
//    
//}
