//
//  MyTabBar.swift
//  Threads-Clone
//
//  Created by Anton Gerasimov on 22.04.2024.
//

import SwiftUI

struct MyTabBar: View {
    @Environment(\.tapBarVm) private var tapBarVm: TapBarViewModel
    
    var body: some View {
        @Bindable var viewModel = tapBarVm
        HStack(spacing: 0) {
            ForEach($viewModel.allTabs) { $animatedTab in
                let tab = animatedTab.tab

                VStack(spacing: 4) {
                    Image(systemName: tab.rawValue)
                        .imageScale(.large)
                        .symbolEffect(.bounce.down.byLayer, value: animatedTab.isAnimating)
                        .environment(\.symbolVariants, tab == viewModel.activeTab ? .fill : .none)
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .foregroundStyle(viewModel.activeTab == tab ? .black : Color.gray.opacity(0.8))
                .padding(.top, 15)
                .padding()
                .contentShape(.rect)
                .onTapGesture {
                    withAnimation(.bouncy, completionCriteria: .logicallyComplete, {
                        viewModel.activeTab = tab
                        animatedTab.isAnimating = true
                    }, completion: {
                        var transaction = Transaction()
                        transaction.disablesAnimations = true
                        withTransaction(transaction) {
                            animatedTab.isAnimating = nil
                        }
                    })
                }
            }
        }
        .background(.white)
    }
}

#Preview {
    ThreadsTabView()
}
