//
//  View.swift
//  Threads-Clone
//
//  Created by Anton Gerasimov on 22.04.2024.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder
    func setUpTab(_ tab: Tab) -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .tag(tab)
            .toolbar(.hidden, for: .tabBar)
    }
}
