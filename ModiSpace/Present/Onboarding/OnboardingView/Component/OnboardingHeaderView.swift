//
//  OnboardingTextViewCell.swift
//  ModiSpace
//
//  Created by 전준영 on 10/27/24.
//

import SwiftUI

struct OnboardingHeaderView: View {
    
    var body: some View {
        Text("새싹톡을 사용하면 어디서나\n팀을 모을 수 있습니다")
            .customFont(.title1)
            .multilineTextAlignment(.center)
            .padding(.top, 40)
    }
    
}

#Preview {
    OnboardingHeaderView()
}
