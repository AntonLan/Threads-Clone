//
//  PreviewProvider.swift
//  Threads-Clone
//
//  Created by Anton Gerasimov on 28.02.2024.
//

import SwiftUI

class DeveloperPreview {
    static let shared = DeveloperPreview()
    
    let user = User(id: NSUUID().uuidString, fullName: "Anton Lan", email: "lanqel@gmail.com", userName: "anton_lan")
}
