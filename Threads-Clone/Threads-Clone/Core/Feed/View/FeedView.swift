//
//  FeedView.swift
//  Threads-Clone
//
//  Created by Anton Gerasimov on 20.02.2024.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(0...10, id: \.self) { thread in
                        ThreadCell()
                    }
                }
            }
            .refreshable {
                print("DEBUG: Refresh thread")
            }
            .navigationTitle("Threads")
            .navigationBarTitleDisplayMode(.inline)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                        .foregroundStyle(.black)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        FeedView()
    }
}
