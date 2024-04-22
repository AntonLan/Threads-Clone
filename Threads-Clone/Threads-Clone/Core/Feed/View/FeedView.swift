//
//  FeedView.swift
//  Threads-Clone
//
//  Created by Anton Gerasimov on 20.02.2024.
//

import SwiftUI

struct FeedView: View {
    @State var viewModel = FeedViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                ThreadsLogoView(animatableProgress: viewModel.animatableProgress)
                LazyVStack {
                    ForEach(viewModel.threads, id: \.id) { thread in
                        ThreadCell(thread: thread)
                    }
                }
                .background(GeometryReader { geometry in
                    viewModel.detectScroll(geometry: geometry)
                })
            }
        }
        .coordinateSpace(name: "ScrollView")
        .refreshable {
            Task { try await viewModel.fetchThreads() }
        }
        .onAppear {
            UIRefreshControl.appearance().tintColor = .clear
        }
    }
}

#Preview {
    NavigationStack {
        FeedView()
    }
}
