//
//  CoinShopView.swift
//  ModiSpace
//
//  Created by 전준영 on 11/15/24.
//

import SwiftUI

struct CoinShopView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                VStack(spacing: 4) {
                    SelectableRow<Never, _>(destination: nil,
                                            showChevron: false) {
                        Text("현재 보유한 코인")
                            .foregroundStyle(.black)
                            .customFont(.bodyBold)
                        
                        Spacer()
                        
                        Text("코인이란?")
                            .foregroundStyle(.gray)
                            .customFont(.bodyBold)
                    }
                }
                .background(.white)
                .cornerRadius(12)
                .padding(.horizontal)
                .padding(.top)
            }
            
            VStack() {
                SelectableRow<Never, _>(destination: nil,
                                        showChevron: false) {
                    StoreCoinCell(titleText: "10 Coin",
                                  realMoneyText: "₩100") {
                        
                    }
                }
                
                SelectableRow<Never, _>(destination: nil,
                                        showChevron: false) {
                    StoreCoinCell(titleText: "50 Coin",
                                  realMoneyText: "₩500"){
                        
                    }
                }
                
                SelectableRow<Never, _>(destination: nil,
                                        showChevron: false) {
                    StoreCoinCell(titleText: "100 Coin",
                                  realMoneyText: "₩1000"){
                        
                    }
                }
            }
            .background(.white)
            .cornerRadius(12)
            .padding(.horizontal)
            .padding(.top)
            
            Spacer()
        }
        .background(Color(.systemGray6))
        .navigationBarTitle("코인샵", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            dismiss()
        }) {
            Image(systemName: "chevron.left")
                .foregroundStyle(.black)
        })
    }
    
}
