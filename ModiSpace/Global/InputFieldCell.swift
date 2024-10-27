//
//  InputFieldCell.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct InputFieldCell: View {
    
    @Binding var text: String
    
    var title: String
    var placeholder: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .bold()
                .padding(.leading)
            
            TextField(placeholder, text: $text)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
        }
        
    }
}

#Preview {
    ChannelView_Home()
}

