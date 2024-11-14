//
//  RegisterChannelView.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct RegisterChannelView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var model: RegisterChannelModel = RegisterChannelModel()
    
    var body: some View {
        VStack(spacing: 24) {
            InputField(text: $model.channelName,
                           title: "채널 이름",
                           placeholder: "채널 이름을 입력하세요 (필수)")
            
            InputField(text: $model.channelDescription,
                           title: "채널 설명",
                           placeholder: "채널을 설명하세요 (옵션)")
            
            Spacer()
            
            CommonButton(icon: nil,
                         backgroundColor: .main,
                         text: "생성",
                         textColor: .white,
                         symbolColor: nil,
                         cornerRadius: 8,
                         isEnabled: model.isRegistAble) {
                model.apply(.registChannel)
                dismiss()
            }
            .padding(.horizontal)
        }
        .padding(.top, 32)
        .background(.gray.opacity(0.2))
        .onTapGesture {
            endTextEditing()
        }
        .onChange(of: model.isExpiredRefreshToken) {
            setRootView(what: OnboardingView())
        }
    }
    
}
