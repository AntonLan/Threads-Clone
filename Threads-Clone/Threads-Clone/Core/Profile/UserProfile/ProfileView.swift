//
//  ProfileView.swift
//  Threads-Clone
//
//  Created by Anton Gerasimov on 20.02.2024.
//

import SwiftUI

struct ProfileView: View {
    let user: User

    var body: some View {
            ScrollView(showsIndicators: false) {
                // bio and stats
                VStack(spacing: 20) {
                    ProfileHeaderView(user: user)
                    
                    Button {
                        
                    } label: {
                        Text("Folow")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 352, height: 32)
                            .background(.black)
                            .cornerRadius(8)
                    }
                    UserContentListView(user: user)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .padding(.horizontal)
    }
}

#Preview {
    ProfileView(user: DeveloperPreview.shared.user)
}
