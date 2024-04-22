//
//  ThreadsTabView.swift
//  Threads-Clone
//
//  Created by Anton Gerasimov on 20.02.2024.
//

import SwiftUI

struct ThreadsTabView: View {
    @State var viewModel = TapBarViewModel()
    
    var body: some View {
        TabView(selection: $viewModel.activeTab) {
            FeedView()
                .setUpTab(.home)
            
            ExploreView()
                .setUpTab(.explore)
            
            Text("")
                .setUpTab(.plus)
            
            ActivityView()
                .setUpTab(.activity)
            
            CurrentUserProfileView()
                .setUpTab(.profile)
            
        }
        .toolbar(.hidden, for: .tabBar)
        .onChange(of: viewModel.activeTab) {
            viewModel.showCreateThreadView = viewModel.activeTab == .plus
        }
        .sheet(isPresented: $viewModel.showCreateThreadView, onDismiss: {
            viewModel.activeTab = .home
        }, content: {
            CreateThreadView()
        })
        .tint(.black)
        
        MyTabBar()
            .environment(\.tapBarVm, viewModel)
    }
}

#Preview {
    ThreadsTabView()
}
