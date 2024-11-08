//
//  AddMemberModel.swift
//  ModiSpace
//
//  Created by 최승범 on 11/6/24.
//

import Foundation

final class AddMemberModel: ObservableObject {
    
    @Published var email = ""
    var workspaceID: String = WorkspaceIDManager.shared.workspaceID ?? ""
    var isAble: Bool = true
    
    func apply(_ intent: AddmemberIntent) {
        
        switch intent {
        case .addMember:
            addMember()
        }
    }
    
}

//MARK: - 직접적인 변경 메서드
extension AddMemberModel {

    private func addMember() {
        Task {
            do {
                let router = WorkSpaceRouter.inviteMember(spaceId: workspaceID,
                                                          body: InviteMemberRequestBody(email: email))
                
                let _ = try await NetworkManager().getData(from: router)
            } catch(let error) {
                print(error.localizedDescription)
            }
        }
    }
    
}
