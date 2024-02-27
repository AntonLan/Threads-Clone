//
//  LoginViewModel.swift
//  Threads-Clone
//
//  Created by Anton Gerasimov on 27.02.2024.
//

import Foundation
import Observation

@Observable
final class LoginViewModel {
    var email = ""
    var password = ""
    
    @MainActor
    func login() async throws {
        try await AuthService.shared.login(withEmail: email, password: password)
    }
    
}
