//
//  LoginViewModel.swift
//  Threads-Clone
//
//  Created by Anton Gerasimov on 27.02.2024.
//

import Foundation
import Observation
import GoogleSignIn
import GoogleSignInSwift

@Observable
final class LoginViewModel {
    var email = ""
    var password = ""
    
    @MainActor
    func login() async throws {
        try await AuthService.shared.login(withEmail: email, password: password)
    }
    
    
    @MainActor
    func singInGoogle() async throws {
        let helper = SingINGoogleHelper()
        let tokens = try await helper.singIn()
        try await AuthService.shared.singInWithGoogle(tokkens: tokens)
    }
    
}
