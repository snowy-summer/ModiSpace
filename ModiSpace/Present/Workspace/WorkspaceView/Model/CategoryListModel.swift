//
//  CategoryListModel.swift
//  ModiSpace
//
//  Created by 최승범 on 11/3/24.
//

import Foundation
import Combine

final class CategoryListModel: ObservableObject {
    
    
    @Published var isShowChannels = false
    @Published var isShowMessageList = false
    @Published var isShowNewMessageView = false
    
    @Published var selectedDirect: String? = nil
    @Published var showActionSheet = false
    @Published var showAddChannelView = false
    
    @Published var sheetType: WorkspaceViewSheetType?
    
    func apply(_ intent: CategoryListIntent) {
        switch intent {
        case .showAddChannelView:
            sheetType = .addChannelView
            
        case .showFindChannelView:
            sheetType = .findChannelView
            
        case .changingShowedChannelState:
            isShowChannels.toggle()
            
        case .showActionSheet:
            showActionSheet = true
        }
    }
    
}
