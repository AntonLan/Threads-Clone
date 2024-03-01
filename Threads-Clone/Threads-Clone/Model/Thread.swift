//
//  Thread.swift
//  Threads-Clone
//
//  Created by Anton Gerasimov on 29.02.2024.
//

import Firebase
import FirebaseFirestoreSwift

struct Thread: Identifiable, Codable {
    @DocumentID var threadId: String?
    let ownerUid: String
    let caption: String
    let timestamp: Timestamp
    var likes: Int
    
    var user: User?
}

extension Thread {
    var id: String {
        return threadId ?? NSUUID().uuidString
    }
}
