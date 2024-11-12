//
//  CustomNavigationRow.swift
//  ModiSpace
//
//  Created by 전준영 on 11/12/24.
//

import SwiftUI

struct CustomNavigationRow<Destination: View, Content: View>: View {
    
    private let destination: Destination?
    private let content: () -> Content
    private let showChevron: Bool

    init(destination: Destination? = nil,
         showChevron: Bool = true,
         @ViewBuilder content: @escaping () -> Content) {
        self.destination = destination
        self.showChevron = showChevron
        self.content = content
    }

    var body: some View {
        Group {
            if let destination = destination {
                NavigationLink(destination: destination) {
                    rowContent
                }
            } else {
                rowContent
            }
        }
    }
    
    private var rowContent: some View {
        HStack {
            content()
            
            if showChevron {
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }
    
}
