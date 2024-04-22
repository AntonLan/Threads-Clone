//
//  Container.swift
//  Threads-Clone
//
//  Created by Anton Gerasimov on 11.04.2024.
//

import Factory

extension Container {
    var userService: Factory<UserService> {
        self { UserService() }
            .singleton
    }
    
    var authService: Factory<AuthService> {
        self { AuthService() }
            .singleton
    }
}
