//
//  AuthService.swift
//  Threads-Clone
//
//  Created by Anton Gerasimov on 27.02.2024.
//

import Firebase

class AuthService {
    
    static let shared = AuthService()
    
    @MainActor
    func login(
        withEmail email: String,
        password: String
    ) async throws {
        
    }
    
    @MainActor
    func createUser(
        withEmail email: String,
        password: String,
        fullName: String,
        userName: String
    ) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            print("Debug: Create user \(result.user.uid)")
        } catch {
            print("Debug: failed to create user \(error.localizedDescription)")
        }
    }
}
