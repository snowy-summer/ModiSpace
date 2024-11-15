//
//  EditChannelView.swift
//  ModiSpace
//
//  Created by 이윤지 on 11/12/24.
//

import SwiftUI

struct EditChannelView: View {
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var model: ChatModel
    
    var body: some View {
        VStack(spacing: 24) {
            InputField(text: $model.channel.name,
                       title: "채널 이름",
                       placeholder: "채널 이름을 입력하세요 (필수)")
            
            InputField(
                text: Binding(
                    get: { model.channel.description ?? "" },
                    set: { model.channel.description = $0 }
                ),
                title: "채널 설명",
                placeholder: "채널을 설명하세요 (옵션)"
            )
            
            Spacer()
            
            CommonButton(icon: nil,
                         backgroundColor: .main,
                         text: "저장",
                         textColor: .white,
                         symbolColor: nil,
                         cornerRadius: 8,
                         isEnabled: model.isEditAble) {
                 model.apply(.editChannel)
                dismiss()
            }
            .padding(.horizontal)
        }
        .padding(.top, 32)
        .background(.gray.opacity(0.2))
        .onTapGesture {
            endTextEditing()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                }
            }
        }
    }
    
}

