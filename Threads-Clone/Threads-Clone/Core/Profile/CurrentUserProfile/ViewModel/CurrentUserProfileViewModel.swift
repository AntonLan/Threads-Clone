//
//  CurrentProfileViewModel.swift
//  Threads-Clone
//
//  Created by Anton Gerasimov on 28.02.2024.
//

import Observation
import Combine

@Observable
final class CurrentUserProfileViewModel {
    var currentUser: User?
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
        }
        .store(in: &cancellable)
    }
}
