//
//  TabView.swift
//  ModiSpace
//
//  Created by 최승범 on 11/12/24.
//

import SwiftUI

struct CustomTabView: View {
    
    @State private var selectedTab: TabComponent = .home
    @StateObject var workspaceModel = WorkspaceModel()
    
    init() {
      UITabBar.appearance().scrollEdgeAppearance = .init()
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                Group {
                    NavigationStack {
                        WorkspaceView(model: workspaceModel)
                    }
                    .tabItem {
                        TabButton(selectedTab: $selectedTab,
                                  tabType: .home)
                    }
                    .tag(TabComponent.home)
                    
                    NavigationStack {
                        DMListView()
                    }
                    .tabItem {
                        TabButton(selectedTab: $selectedTab,
                                  tabType: .dm)
                    }
                    .tag(TabComponent.dm)
                    
                    NavigationStack {
                        WorkspaceView()
                    }
                    .tabItem {
                        TabButton(selectedTab: $selectedTab,
                                  tabType: .search)
                    }
                    .tag(TabComponent.search)
                    
                    NavigationStack {
                        WorkspaceView()
                    }
                    .tabItem {
                        TabButton(selectedTab: $selectedTab,
                                  tabType: .setting)
                    }
                    .tag(TabComponent.setting)
                }
            }
            .toolbar(.hidden, for: .tabBar)
        }
        .edgesIgnoringSafeArea(.bottom)
        .overlay {
            if workspaceModel.isShowSideView {
                Rectangle()
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            workspaceModel.apply(.dontShowSideView)
                        }
                    }
                
                SideMenuView()
                    .environmentObject(workspaceModel)
                    .transition(.move(edge: .leading))
                    .dragGesture(direction: .left) {
                        workspaceModel.apply(.dontShowSideView)
                    }
            }
            
            if workspaceModel.isShowDeleteAlertView {
                Rectangle()
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            workspaceModel.apply(.dontShowDeleteAlert)
                        }
                    }
                AlertView(
                    title: "워크스페이스 삭제",
                    message: "정말 이 워크스페이스를 삭제하시겠습니까? 삭제 시 모든 데이터가 사라지며 복구할 수 없습니다.",
                    primaryButtonText: "취소",
                    secondaryButtonText: "삭제",
                    onPrimaryButtonTap: { workspaceModel.apply(.dontShowDeleteAlert) },
                    onSecondaryButtonTap: { workspaceModel.apply(.deleteWorkspace) }
                )
            }
        }
        
    }
    
}

struct TabButton: View {
    
    @Binding var selectedTab: TabComponent
    let tabType: TabComponent
    
    var body: some View {
        Button(action: {
            selectedTab = tabType
        }) {
            VStack(spacing: 4) {
                Image(systemName: tabType.icon)
                    .font(.system(size: 24))
                    .foregroundColor(selectedTab == tabType ? .black : .gray)
                
                Text(tabType.title)
                    .font(.caption)
                    .foregroundColor(selectedTab == tabType ? .black : .gray)
            }
        }
    }
    
}

enum TabComponent: Int, CaseIterable {
    case home
    case dm
    case search
    case setting
    
    var title: String {
        switch self {
        case .home:
            return "홈"
            
        case .dm:
            return "DM"
            
        case .search:
            return "검색"
            
        case .setting:
            return "설정"
        }
    }
    
    var icon: String {
        switch self {
        case .home:
            return "list.bullet"
            
        case .dm:
            return "paperplane"
            
        case .search:
            return "magnifyingglass"
            
        case .setting:
            return "rectangle.grid.2x2"
        }
    }
}

#Preview {
    CustomTabView()
}

