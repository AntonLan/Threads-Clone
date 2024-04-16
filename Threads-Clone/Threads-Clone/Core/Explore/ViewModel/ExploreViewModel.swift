//
//  ExploreViewModel.swift
//  Threads-Clone
//
//  Created by Anton Gerasimov on 28.02.2024.
//

import Foundation
import Observation
import Factory

@Observable
final class ExploreViewModel {
    var users = [User]()
    
    init() {
        Task {
            try await fetchUsers()
        }
    }
    
    @MainActor
    private func fetchUsers() async throws {
        self.users = try await UserService.fetchUsers()
    }
}
