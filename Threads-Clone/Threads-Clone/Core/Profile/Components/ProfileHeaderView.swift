//
//  ProfileHeaderView.swift
//  Threads-Clone
//
//  Created by Anton Gerasimov on 28.02.2024.
//

import SwiftUI

struct ProfileHeaderView: View {
    var user: User?
    
    init(user: User?) {
        self.user = user
    }
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 12) {
                // fullname and username
                VStack(alignment: .leading, spacing: 4) {
                    Text(user?.fullName ?? "")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(user?.userName ?? "")
                        .font(.subheadline)
                }
                
                if let bio = user?.bio {
                    Text(bio)
                        .font(.footnote)
                }
                
                Text("2 folowers")
                    .font(.caption2)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            CircularProfileImageView()
        }
    }
}

#Preview {
    ProfileHeaderView(user: DeveloperPreview.shared.user)
}
