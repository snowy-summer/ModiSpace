//
//  InputField.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct InputField: View {
    
    @Binding var text: String
    
    var title: String?
    var placeholder: String
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let title = title {
                Text(title)
                    .bold()
                    .padding(.leading)
            }
            
            TextField(placeholder, text: $text)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
        }
    }
    
}

struct InputField_Previews: PreviewProvider {
    
    @State static var text: String = ""
    
    static var previews: some View {
        VStack(spacing: 20) {
            InputField(text: $text,
                       title: "연락처",
                       placeholder: "전화번호를 입력하세요")
            
            InputField(text: $text,
                       title: nil,
                       placeholder: "전화번호를 입력하세요",
                       keyboardType: .numberPad)
        }
        .padding()
        .background(.backgroundPrimary)
    }
    
}
