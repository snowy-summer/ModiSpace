//
//  DMChattingView.swift
//  ModiSpace
//
//  Created by 전준영 on 11/16/24.
//

import SwiftUI

struct DMChattingView: View {
    
    @Environment(\.modelContext) private var modelContext
    @StateObject private var model: DMChatModel
    
    init(dms: DMSDTO) {
        _model = StateObject(wrappedValue: DMChatModel(dms: dms))
    }
    
    var body: some View {
        VStack {
            DMChattingScrollListView(messages: $model.messages)
            
            ChatTextField(
                messageText: $model.messageText,
                selectedImages: $model.selectedImages,
                isShowingImagePicker: $model.isShowingImagePicker,
                onSendMessage: model.sendMessage,
                onRemoveImage: model.removeImage
            )
            .padding(.horizontal, 16)
            .background(Color(UIColor.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal)
            .padding(.bottom)
        }
        
        .navigationTitle(model.dms.user.nickname)
        .toolbar(.hidden, for: .tabBar)
        .onTapGesture {
            endTextEditing()
        }
        .onAppear {
            model.apply(.fetchMessages(modelContext))
            model.apply(.socketConnect)
        }
        .onDisappear {
            model.apply(.socketDisconnect)
        }
        .onChange(of: model.isExpiredRefreshToken) {
            setRootView(what: OnboardingView())
        }
    }
    
}

extension DMChattingView {
    
    func removeImage(at index: Int) {
        model.selectedImages.remove(at: index)
    }
    
}

