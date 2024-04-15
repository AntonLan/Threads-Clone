//
//  AuthService.swift
//  Threads-Clone
//
//  Created by Anton Gerasimov on 27.02.2024.
//

import Firebase
import FirebaseFirestoreSwift
import Factory
import Combine


enum AuthProviderOption: String {
    case email = "password"
    case google = "google.com"
}

class AuthService {
    
    @Published var userSession: FirebaseAuth.User?
    
    static var shared = AuthService()
    
//    @Injected(\.userService) private var userService
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    func getProvider() throws -> [AuthProviderOption] {
        guard let providerData = Auth.auth().currentUser?.providerData else {
            throw URLError(.badServerResponse)
        }
        var providers: [AuthProviderOption] = []
        for provider in providerData {
            if let option = AuthProviderOption(rawValue: provider.providerID) {
                providers.append(option)
            } else {
                assertionFailure("Provider option not found: \(provider.providerID)")
            }
        }
        
        return providers
    }
    
    @MainActor
    func login(
        withEmail email: String,
        password: String
    ) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            try await UserService.shared.fetchCurrentUser()
        } catch {
            print("Debug: failed to create user \(error.localizedDescription)")
        }
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
            self.userSession = result.user
            try await uploadUserData(withEmail: email, fullName: fullName, userName: userName, id: result.user.uid)
        } catch {
            print("Debug: failed to create user \(error.localizedDescription)")
        }
    }
    
    func singOut() {
        try? Auth.auth().signOut() // sign out on backend
        self.userSession = nil // remove session localy and update routing
        UserService.shared.reset() // set current user to nil
    }
    
    
    @MainActor
    private func uploadUserData(
        withEmail email: String,
        fullName: String,
        userName: String,
        id: String
    ) async throws {
        let user = User(id: id, fullName: fullName, email: email, userName: userName)
        guard let userData = try? Firestore.Encoder().encode(user) else { return }
        try await Firestore.firestore().collection("users").document(id).setData(userData)
        UserService.shared.currentUser = user
    }
}

// MARK: Sing in google
extension AuthService {
    
    func singInWithGoogle(tokkens: GoogleSingInResultModel) async throws {
        let credential  = GoogleAuthProvider.credential(withIDToken: tokkens.idToken, accessToken: tokkens.accessToken)
        try await singIn(credential: credential)
        
        let users = try await UserService.getAllUsers()
        
        guard let id = userSession?.uid else { return }
        
        for user in users {
            if user.id != id {
                try await uploadUserData(withEmail: tokkens.email, fullName: tokkens.fullName, userName: tokkens.userName, id: id)
            } else {
                try await UserService.shared.fetchCurrentUser()
            }
        }
        
        
    }
    
    func singIn(credential: AuthCredential) async throws {
        do {
            let result = try await Auth.auth().signIn(with: credential)
            self.userSession = result.user
        } catch {
            print("Debug: failed to create user \(error.localizedDescription)")
        }
    }
    
}
