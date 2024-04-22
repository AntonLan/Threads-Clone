//
//  CurrentProfileViewModel.swift
//  Threads-Clone
//
//  Created by Anton Gerasimov on 28.02.2024.
//

import Observation
import Combine
import Factory

@Observable
final class CurrentUserProfileViewModel {
    var currentUser: User?
    private var cancellable = Set<AnyCancellable>()
    
    @ObservationIgnored
    @Injected(\.authService) private var authService
    
    @ObservationIgnored
    @Injected(\.userService) private var userService
    
    init() {
        setupSubscribers()
    }
    
    func singOut() {
        authService.singOut()
    }
    
    private func setupSubscribers() {
        userService.$currentUser.sink { [weak self] user in
            self?.currentUser = user
        }
        .store(in: &cancellable)
    }
}
