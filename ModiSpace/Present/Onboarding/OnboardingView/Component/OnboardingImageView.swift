//
//  OnboardingImageViewCell.swift
//  ModiSpace
//
//  Created by 전준영 on 10/27/24.
//

import SwiftUI

struct OnboardingImageView: View {
    
    var width: CGFloat
    
    var body: some View {
        
        Image("onboarding")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width - 80, height: width - 80)
            .padding(.bottom, 40)
        
    }
    
}

#Preview {
    GeometryReader { geometry in
        OnboardingImageView(width: geometry.size.width)
    }
}
