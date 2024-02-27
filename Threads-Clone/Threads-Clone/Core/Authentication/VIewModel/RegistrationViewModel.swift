//
//  RegistrationViewModel.swift
//  Threads-Clone
//
//  Created by Anton Gerasimov on 27.02.2024.
//

import Foundation
import Observation

@Observable
final class RegistrationViewModel {
    
    var email = ""
    var password = ""
    var fullName = ""
    var userName = ""
    
    
    @MainActor
    func createUser() async throws {
        try await AuthService.shared.createUser(withEmail: email, password: password, fullName: fullName, userName: userName)
    }
}
