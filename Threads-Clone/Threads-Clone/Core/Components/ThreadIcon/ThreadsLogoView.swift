//
//  ThreadsLogoView.swift
//  Threads-Clone
//
//  Created by Anton Gerasimov on 01.03.2024.
//

import SwiftUI

struct ThreadsLogoView: View {
    var animatableProgress: CGFloat
    let letterAnimationDuration = 0.5
    let nameTransitionDuration = 0.5
    
    var body: some View {
        VStack {
            ZStack {
                ThreadsIcon()
                    .foregroundColor(Color.gray.opacity(0.3))
                    .frame(width: 30, height: 35)
                
                ThreadsIcon()
                    .trim(from: 0, to: animatableProgress)
                    .stroke(style: StrokeStyle(lineWidth: 7, lineCap: .round, lineJoin: .round))
                    .foregroundStyle(.black)
                    .animation(
                        Animation.easeInOut(duration: 2)
                            .repeatForever(autoreverses: true),
                        value: animatableProgress
                    )
                    .frame(width: 30, height: 35)
                    .mask(
                        GeometryReader { geometry in
                            Path { path in
                                path.addPath(
                                    ThreadsIcon()
                                        .trim(from: 0, to: animatableProgress)
                                        .path(in: CGRect(x: 0, y: 0, width: geometry.size.width, height: geometry.size.height))
                                )
                            }
                            .fill(Color.white)
                        }
                    )
            }
        }
        .frame(width: 40, height: 40)
    }
}

#Preview {
    ThreadsLogoView(animatableProgress: 1.0)
}
