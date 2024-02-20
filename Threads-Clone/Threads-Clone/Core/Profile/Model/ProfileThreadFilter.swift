//
//  ProfileThreadFilter.swift
//  Threads-Clone
//
//  Created by Anton Gerasimov on 20.02.2024.
//

import Foundation

enum ProfileThreadFilter: Int, CaseIterable, Identifiable {
    case threads = 0
    case replies = 1
    
    var title: String {
        switch self {
        case .threads: return "Threads"
        case .replies: return "Replies"
        }
    }
    
    var id: Int { return self.rawValue }
}
