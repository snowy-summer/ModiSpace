//
//  OnboardingButtonCell.swift
//  ModiSpace
//
//  Created by 전준영 on 10/27/24.
//

import SwiftUI

struct OnboardingButtonCell: View {
    
    @Binding var showAuthOption: Bool
        
    var body: some View {
        
        Button(action: {
            showAuthOption.toggle()
        }) {
            CustomButton(icon: nil, backgroundColor: .main, text: "시작하기",
                         textColor: .white, symbolColor: nil, cornerRadius: 10)
        }
        .padding(.bottom, 20)
        .sheet(isPresented: $showAuthOption) {
            AuthOptionsView()
        }
        
    }
    
}

#Preview {
    OnboardingButtonCell(showAuthOption: .constant(false))
}
