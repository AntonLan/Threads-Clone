//
//  User.swift
//  Threads-Clone
//
//  Created by Anton Gerasimov on 28.02.2024.
//

import Foundation

struct User: Identifiable, Codable, Hashable {
    let id: String
    let fullName: String
    let email: String
    let userName: String
    var profileImageUrl: String?
    var bio: String?
}
