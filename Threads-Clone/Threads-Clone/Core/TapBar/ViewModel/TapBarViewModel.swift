//
//  TapBarViewModel.swift
//  Threads-Clone
//
//  Created by Anton Gerasimov on 22.04.2024.
//

import Foundation
import Observation
import SwiftUI

@Observable
final class TapBarViewModel {
    
    
    var activeTab: Tab = .home
    var showCreateThreadView = false
    var allTabs: [AnimatedTab] = Tab.allCases.compactMap { tab -> AnimatedTab? in
        return .init(tab: tab)
    }
    
    
}

struct TapBarVmKey: EnvironmentKey {
    static var defaultValue: TapBarViewModel = TapBarViewModel()
}

extension EnvironmentValues {
    var tapBarVm: TapBarViewModel {
        get { self[TapBarVmKey.self] }
        set { self[TapBarVmKey.self] = newValue }
    }
}
