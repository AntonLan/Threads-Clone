//
//  SingINGoogleHelper.swift
//  Threads-Clone
//
//  Created by Anton Gerasimov on 11.04.2024.
//

struct GoogleSingInResultModel {
    var idTocken: String
    var accessToken: String
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
        
        let tokens = GoogleSingInResultModel(idTocken: idToken, accessToken: accessToken)
        
        return tokens
    }

}
