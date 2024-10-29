//
//  ChannelView_Home.swift
//  ModiSpace
//
//  Created by 이윤지 on 10/26/24.
//

import SwiftUI

struct WorkspaceView: View {
    
    @State private var isChannelsShow = false
    @State private var isDirectShow = false
    @State private var showNewMessageView = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack {
                    WorkspaceHeaderView()
                    
                    Divider()
                    
                    ScrollView{
                        CategoryListView(isChannelsShow: $isChannelsShow,
                                         isDirectShow: $isDirectShow,
                                         showNewMessageView: $showNewMessageView)
                        
                        SFSubButton(text: "팀원 추가") {}
                            .padding()
                        
                        Spacer()
                    }
                }
                
                AddPostCircleCell {}
                    .frame(width: 50, height: 50)
                    .position(x: geometry.size.width - 45,
                              y: geometry.size.height - 35)
            }
            .navigationDestination(isPresented: $showNewMessageView) {
                NewMessageView()
            }
        }
    }
    
}

#Preview {
    WorkspaceView()
}