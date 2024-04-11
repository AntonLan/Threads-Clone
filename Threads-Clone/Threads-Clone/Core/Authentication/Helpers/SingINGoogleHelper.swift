//
//  SingINGoogleHelper.swift
//  Threads-Clone
//
//  Created by Anton Gerasimov on 11.04.2024.
//

import GoogleSignIn
import GoogleSignInSwift

struct GoogleSingInResultModel {
    var idToken: String
    var accessToken: String
    var fullName: String
    var email: String
    var userName: String
}

final class SingINGoogleHelper {
    
    @MainActor
    func singIn() async throws -> GoogleSingInResultModel {
        guard let topVc = Utilites.shared.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        
        let gidSingInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVc)
        
        guard let idToken = gidSingInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        
        let accessToken = gidSingInResult.user.accessToken.tokenString
        
        guard let fullName = gidSingInResult.user.profile?.name else {
            throw URLError(.badServerResponse)
        }
        
        guard let email = gidSingInResult.user.profile?.email else {
            throw URLError(.badServerResponse)
        }
        
        guard let userName = gidSingInResult.user.profile?.familyName else {
            throw URLError(.badServerResponse)
        }


        let tokens = GoogleSingInResultModel(idToken: idToken, accessToken: accessToken, fullName: fullName, email: email, userName: userName)
        
        return tokens
    }

}
