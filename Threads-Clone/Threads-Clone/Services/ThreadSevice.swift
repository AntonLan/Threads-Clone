//
//  ThreadSevice.swift
//  Threads-Clone
//
//  Created by Anton Gerasimov on 29.02.2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct ThreadSevice {
    
    static func uploadThread(_ thread: Thread) async throws {
        guard let threadData = try? Firestore.Encoder().encode(thread) else { return }
        try await Firestore.firestore().collection("threads").addDocument(data: threadData)
    }
}
