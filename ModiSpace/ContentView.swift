//
//  ContentView.swift
//  ModiSpace
//
//  Created by 최승범 on 10/24/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .customFont(.body)
            
            List() {
                WorkSpaceCell()
            }
            .listStyle(.plain)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
