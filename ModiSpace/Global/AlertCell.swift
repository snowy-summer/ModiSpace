//
//  AlertCell.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI
//MARK: - 얼럿 컴포넌트 사용 예시
struct Alert_TestView: View {
    var body: some View {
        VStack(spacing: 20) {
            AlertCell(
                title: "워크스페이스 관리자 변경 불가",
                message: "워크스페이스 멤버가 없어 관리자 변경을 할 수 없습니다.\n새로운 멤버를 초대해 주세요.",
                primaryButtonText: "확인",
                onPrimaryButtonTap: { print("확인버튼") }
            )
            
            AlertCell(
                title: "워크스페이스 삭제",
                message: "정말 이 워크스페이스를 삭제하시겠습니까? 삭제 시 모든 데이터가 사라지며 복구할 수 없습니다.",
                primaryButtonText: "취소",
                secondaryButtonText: "삭제",
                onPrimaryButtonTap: { print("취소버튼") },
                onSecondaryButtonTap: { print("삭제버튼") }
            )
            
            AlertCell(
                title: "Hue 님을 관리자로 지정하시겠습니까?",
                message: """
                        워크스페이스 관리자에게는 다음과 같은 권한이 있습니다.
                        • 워크스페이스 이름 또는 설명 변경
                        • 워크스페이스 삭제
                        • 워크스페이스 멤버 초대
                        """,
                primaryButtonText: "취소",
                secondaryButtonText: "확인",
                onPrimaryButtonTap: { print("취소버튼") },
                onSecondaryButtonTap: { print("확인버튼") }
            )
        }
        .background(Color.gray)
        
    }
}



//MARK: - 얼럿 컴포넌트
struct AlertCell: View {
    
    var title: String
    var message: String
    var primaryButtonText: String
    var secondaryButtonText: String? = nil
    var onPrimaryButtonTap: () -> Void
    var onSecondaryButtonTap: (() -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 12) {
            Text(title)
                .font(.headline)
                .padding(.top)
            
            Text(message)
                .font(.body)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            HStack(spacing: 12) {
                if let secondaryText = secondaryButtonText, let onSecondaryTap = onSecondaryButtonTap {
                    Button(action: onSecondaryTap) {
                        Text(secondaryText)
                            .font(.body)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundStyle(.white)
                            .cornerRadius(8)
                    }
                }
                
                Button(action: onPrimaryButtonTap) {
                    Text(primaryButtonText)
                        .font(.body)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(secondaryButtonText == nil ? Color.green : Color.gray)
                        .foregroundStyle(.white)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .frame(maxWidth: 400)
        .background(Color.white)
        .cornerRadius(10)
        .padding()
        .shadow(radius: 10)
        
    }
}


#Preview {
    Alert_TestView()
}


