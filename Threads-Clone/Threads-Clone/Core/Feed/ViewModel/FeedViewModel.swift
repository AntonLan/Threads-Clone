//
//  FeedViewModel.swift
//  Threads-Clone
//
//  Created by Anton Gerasimov on 29.02.2024.
//

import Foundation
import Observation
import SwiftUI

@Observable
final class FeedViewModel {
    var threads = [Thread]()
    var animatableProgress: CGFloat = 0
    
    init() {
        Task {
            try await fetchThreads()
        }
    }
    
    @MainActor
    func fetchThreads() async throws {
        threads = try await ThreadSevice.fetchThreads()
        try await fetchUserDataForThreads()
    }
    
    @MainActor
    private func fetchUserDataForThreads() async throws {
        for i in 0..<threads.count {
            let thread = threads[i]
            let ownerUid = thread.ownerUid
            let threadUser = try await UserService.fetchUser(withUid: ownerUid)
            
            threads[i].user = threadUser
        }
    }
    
    func detectScroll(geometry: GeometryProxy) -> some View {
        let yOffset = geometry.frame(in: .named("ScrollView")).minY
        DispatchQueue.main.async {
            self.animatableProgress = (yOffset / 100) - 1.07
        }
        return Rectangle().fill(Color.clear)
    }
}
