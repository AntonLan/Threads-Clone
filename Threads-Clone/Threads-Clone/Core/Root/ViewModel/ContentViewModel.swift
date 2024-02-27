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
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        AuthService.shared.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
        }.store(in: &cancellables)
        print(cancellables)
    }
    
}
