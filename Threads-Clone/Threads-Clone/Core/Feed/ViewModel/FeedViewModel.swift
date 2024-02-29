//
//  FeedViewModel.swift
//  Threads-Clone
//
//  Created by Anton Gerasimov on 29.02.2024.
//

import Foundation
import Observation

@Observable
final class FeedViewModel {
    var threads = [Thread]()
    
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
}
