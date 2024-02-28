//
//  ProfileViewModel.swift
//  Threads-Clone
//
//  Created by Anton Gerasimov on 28.02.2024.
//

import Foundation
import Observation

@Observable
final class ProfileViewModel {
    var currentUser: User?
    
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        _ = UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
            print("DEBUG: User in view model from observation is \(String(describing: user))")
        }
    }
}
