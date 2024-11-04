//
//  ChatModel.swift
//  ModiSpace
//
//  Created by 이윤지 on 11/2/24.
//

//import SwiftUI
//
//final class ChatModel: ObservableObject {
//    
//    @Published var messages: [DummyMessage] = []
//    @Published var messageText: String = ""
//    @Published var selectedImages: [UIImage] = []
//    @Published var isShowingImagePicker = false
//
//    private let networkManager = NetworkManager()
//    
//    func apply(_ intent: ChatIntent) {
//        switch intent {
//        case .sendMessage(let text, let images):
//            postChatMessage(text: text, images: images)
//            
//        case .removeImage(let index):
//            removeImage(at: index)
//            
//        case .showImagePicker(let show):
//            isShowingImagePicker = show
//            
//        }
//    }
//
//}
//
//extension ChatModel {
//    func getChannelChatsData() {
//        let workspaceID = "12a75244-5c0f-4478-becd-d2c95820de56"
//        let channelID = "f8ff1a63-8278-4529-ac88-fea037af75aa"
//        let cursorDate: String? = "2024-10-30"
//        
//        Task {
//            do {
//                // getDecodedData를 사용하여 `[DummyMessage]`로 디코딩된 데이터를 가져옵니다.
//                let decodedMessages = try await networkManager.getDecodedData(
//                    from: ChannelRouter.getChannelListChat(
//                        workspaceID: workspaceID,
//                        channelID: channelID,
//                        cursorDate: cursorDate
//                    ),
//                    type: [DummyMessage].self,
//                    retryCount: 3
//                )
//                
//                // 메인 스레드에서 `messages` 업데이트
//                DispatchQueue.main.async {
//                    self.messages = decodedMessages
//                    print("데이터 가져오기 성공")
//                }
//            } catch {
//                print("Failed to fetch chat data:", error)
//            }
//        }
//    }
//}
//
//
//
//
//
//
//
//extension ChatModel {
//    private func postChatMessage(text: String, images: [UIImage]) {
//        // Optional이 아닌 임시값을 직접 할당
//        let workspaceID = "12a75244-5c0f-4478-becd-d2c95820de56"
//        let channelID = "f8ff1a63-8278-4529-ac88-fea037af75aa"
//        
//        // 이미지를 Data로 변환하여 files 배열 생성
//        let imageFiles = images.compactMap { $0.jpegData(compressionQuality: 0.8) }
//        
//        // SendChannelChatRequestBody 초기화
//        let requestBody = SendChannelChatRequestBody(content: text, files: imageFiles)
//        
//        Task {
//            do {
//                let response = try await networkManager.getDataWithPublisher(
//                    from: ChannelRouter.sendChannelChat(
//                        workspaceID: workspaceID,
//                        channelID: channelID,
//                        body: requestBody
//                    )
//                )
//                
//                DispatchQueue.main.async {
//                    // 필요시 `messages` 업데이트
//                    // self.messages.append(contentsOf: response)
//                    print("통신 성공")
//                }
//            } catch {
//                print("Failed to send chat message:", error)
//            }
//        }
//    }
//}
//
//
//
////extension ChatModel {
////    // 메시지 전송 기능을 위한 별도 메서드
////    private func sendMessage(text: String, images: [UIImage]) {
////        guard !text.isEmpty || !images.isEmpty else { return }
////        
////        let newMessage = DummyMessage(text: text, isCurrentUser: false, profileImage: "person.crop.rectangle", imageUrls: []
////         
////        )
////        messages.append(newMessage)
////        messageText = ""
////        selectedImages = []
////    }
////
////    // 이미지 제거 기능을 위한 별도 메서드
////    private func removeImage(at index: Int) {
////        guard index >= 0 && index < selectedImages.count else { return }
////        selectedImages.remove(at: index)
////    }
////    
////}
