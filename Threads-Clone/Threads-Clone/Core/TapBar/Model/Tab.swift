//
//  Tab.swift
//  Threads-Clone
//
//  Created by Anton Gerasimov on 22.04.2024.
//

import Foundation

enum Tab: String, CaseIterable {
    case home = "house"
    case explore = "magnifyingglass"
    case plus = "plus"
    case activity = "heart"
    case profile = "person"
}

struct AnimatedTab: Identifiable {
    var id: UUID = .init()
    var tab: Tab
    var isAnimating: Bool?
}
