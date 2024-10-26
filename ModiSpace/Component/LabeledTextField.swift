//
//  LabeledTextField.swift
//  ModiSpace
//
//  Created by 전준영 on 10/26/24.
//

import SwiftUI

struct LabeledTextField: View {
    
    let labelText: String? //라벨 없을수 있으니 옵셔널
    let placeholder: String
    var keyboardType: UIKeyboardType = .default //키보드 타입 선정 가능(기본값 미리 설정)
    
    @Binding var text: String
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 6) {
            
            if let labelText = labelText {
                Text(labelText)
                    .customFont(.title1)
                    .foregroundStyle(.black)
            }
            
            TextField(placeholder, text: $text)
                .padding()
                .background(.white)
                .cornerRadius(8)
                .customFont(.title2)
                .keyboardType(keyboardType)
                .accentColor(.black)
            
        }
        
    }
    
}

struct LabeledTextField_Previews: PreviewProvider {
    @State static var text: String = ""
    
    static var previews: some View {
        VStack(spacing: 20) {
            LabeledTextField(labelText: "연락처",
                             placeholder: "전화번호를 입력하세요",
                             text: $text)
            
            //라벨 없을때 사용, 키보드 설정
            LabeledTextField(labelText: nil,
                             placeholder: "전화번호를 입력하세요",
                             keyboardType: .numberPad, text: $text)
            
        }
        .padding()
        .background(.backgroundPrimary)
    }
}
