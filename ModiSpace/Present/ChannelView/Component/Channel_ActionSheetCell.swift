//
//  Channel_ActionSheetCell.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct Channel_ActionSheetCell: View {
    
    @Binding var isPresented: Bool
    
    let actions: [ActionSheet.Button]
    
    var body: some View {
        EmptyView()
            .actionSheet(isPresented: $isPresented) {
                ActionSheet(
                    title: Text(""),
                    buttons: actions
                )
            }
        
    }
}
