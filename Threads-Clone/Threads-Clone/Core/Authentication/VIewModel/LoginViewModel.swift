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
        guard let topVc = Utilites.shared.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        
        let gidSingInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVc)
        
        guard let idToken = gidSingInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        
        let accessToken = gidSingInResult.user.accessToken.tokenString
        
        let tokens = GoogleSingInResultModel(idTocken: idToken, accessToken: accessToken)
        
        try await AuthService.shared.singInWithGoogle(tokkens: tokens)
    }
    
}
