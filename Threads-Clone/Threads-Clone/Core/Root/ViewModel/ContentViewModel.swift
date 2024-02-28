//
//  ContentViewModel.swift
//  Threads-Clone
//
//  Created by Anton Gerasimov on 27.02.2024.
//

import Foundation
import Observation
import Firebase
import Combine

@Observable
final class ContentViewModel {
    var userSession: FirebaseAuth.User?
    
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        _ = AuthService.shared.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
        }
    }
    
}
