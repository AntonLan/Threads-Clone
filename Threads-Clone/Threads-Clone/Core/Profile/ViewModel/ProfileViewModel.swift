//
//  ProfileViewModel.swift
//  Threads-Clone
//
//  Created by Anton Gerasimov on 28.02.2024.
//

import Foundation
import Observation
import Combine

@Observable
final class ProfileViewModel {
    var currentUser: User?
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
            print("DEBUG: User in view model from observation is \(String(describing: user))")
        }
        .store(in: &cancellable)
    }
}
