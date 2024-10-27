//
//  OnboardingView.swift
//  ModiSpace
//
//  Created by 전준영 on 10/27/24.
//

import SwiftUI

struct OnboardingView: View {
    
    @State private var showAuthOption = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                OnboardingTextViewCell()
                
                Spacer()
                
                OnboardingImageViewCell(width: geometry.size.width)
                
                Spacer()
                
                OnboardingButtonCell(showAuthOption: $showAuthOption)
            }
            .padding()
        }
    }
    
}

#Preview {
    OnboardingView()
}
