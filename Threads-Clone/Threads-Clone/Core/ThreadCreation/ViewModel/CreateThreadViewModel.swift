//
//  CreateThreadViewModel.swift
//  Threads-Clone
//
//  Created by Anton Gerasimov on 29.02.2024.
//

import Observation
import Firebase

@Observable
final class CreateThreadViewModel {
    
    func uploadThread(_ caption: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let thread = Thread(ownerUid: uid, caption: caption, timestamp: Timestamp(), likes: 0)
        try await ThreadSevice.uploadThread(thread)
    }
}
