//
//  UserContentListViewModel.swift
//  Threads-Clone
//
//  Created by Anton Gerasimov on 01.03.2024.
//

import Observation

@Observable
final class UserContentListViewModel {
    var threads = [Thread]()
    
    @ObservationIgnored
    let user: User
    
    init(user: User) {
        self.user = user
        Task { try await fetchUserThreads() }
    }
    
    @MainActor
    func fetchUserThreads() async throws {
        var threads = try await ThreadSevice.fetchUserThreads(uid: self.user.id)
        for i in 0..<threads.count {
            threads[i].user = self.user
        }
        self.threads = threads
    }
    
}
