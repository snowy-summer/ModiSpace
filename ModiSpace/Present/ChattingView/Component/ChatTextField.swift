//
//  ChatTextField.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/31/24.
//

import SwiftUI

struct ChatTextField: View {
    
    @Binding var messageText: String
    @Binding var selectedImages: [UIImage]
    @Binding var isShowingImagePicker: Bool
    
    @State private var textFieldHeight: CGFloat = 40
    
    var onSendMessage: () -> Void
    var onRemoveImage: (Int) -> Void
    
    var body: some View {
        HStack {
            Button(action: {
                isShowingImagePicker = true
            }) {
                Image(systemName: "plus")
                    .foregroundStyle(.gray)
            }
            .sheet(isPresented: $isShowingImagePicker) {
                PhotoPicker(selectedImages: $selectedImages)
            }
            
            VStack {
                ZStack(alignment: .leading) {
                    if messageText.isEmpty {
                        Text("메시지를 입력하세요")
                            .foregroundStyle(.gray)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                    }
                    
                    TextEditor(text: $messageText)
                        .scrollContentBackground(.hidden)
                        .frame(minHeight: textFieldHeight,
                               maxHeight: 150)
                        .padding(8)
                        .cornerRadius(20)
                        .onChange(of: messageText) { _ in
                            updateTextFieldHeight()
                        }
                        .opacity(messageText.isEmpty ? 0.25 : 1)
                }
                .frame(height: textFieldHeight)
                
                TextFieldAttachImageScrollView(images: selectedImages,
                                               onRemoveImage: onRemoveImage)
            }
            
            Button(action: {
                onSendMessage()
            }) {
                Image(systemName: "paperplane.fill")
                    .foregroundStyle((messageText.isEmpty && selectedImages.isEmpty) ? .gray : .green)
                    .padding(4)
            }
            .disabled(messageText.isEmpty && selectedImages.isEmpty)
        }
    }
    
}

extension ChatTextField {
    
    private func updateTextFieldHeight() {
        let font = UIFont.systemFont(ofSize: 16)
        let textWidth = UIScreen.main.bounds.width - 64
        let boundingRect = NSString(string: messageText)
            .boundingRect(with: CGSize(width: textWidth,
                                       height: .infinity),
                          options: .usesLineFragmentOrigin,
                          attributes: [.font: font],
                          context: nil)
        
        let lineHeight = font.lineHeight
        let lineCount = Int(ceil(boundingRect.height / lineHeight))
        
        textFieldHeight = max(40, CGFloat(lineCount) * lineHeight + 26)
    }
    
}

#Preview {
    ChattingView(chatTitle: "Chat")
}
