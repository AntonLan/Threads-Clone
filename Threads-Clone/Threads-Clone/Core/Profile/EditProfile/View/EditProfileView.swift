//
//  EditProfileView.swift
//  Threads-Clone
//
//  Created by Anton Gerasimov on 27.02.2024.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @State private var bio = ""
    @State private var link = ""
    @State private var isPrivateProfile = false
    @Environment(\.dismiss) var dismis
    @State var viewModel = EditProfileViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .edgesIgnoringSafeArea([.bottom, .horizontal])
                VStack {
                    HStack {
                        
                        VStack(alignment: .leading) {
                            Text("Name")
                                .fontWeight(.semibold)
                            Text("Sponge Bob")
                        }
                        
                        Spacer()
                        
                        PhotosPicker(selection: $viewModel.selectedItem) {
                            if let image = viewModel.progileImage {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                            } else {
                                CircularProfileImageView()
                            }
                            
                        }
                    }
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text("Bio")
                            .fontWeight(.semibold)
                        TextField("Enter you bio..", text: $bio, axis: .vertical)
                    }
                    
                    Divider()
                                        
                    VStack(alignment: .leading) {
                        Text("Link")
                            .fontWeight(.semibold)
                        TextField("Add you link..", text: $link)
                    }
                    
                    Divider()
            
                    Toggle("Private Profile", isOn: $isPrivateProfile)
                    
                    Divider()
                }
                .font(.footnote)
                .padding()
                .background(.white)
                .cornerRadius(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                }
                .padding()
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button ("Cancel") {
                        dismis()
                    }
                    .font(.subheadline)
                    .foregroundStyle(.black)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button ("Done") {
                        Task {
                            try await viewModel.updateUserData()
                            dismis()
                        }
                    }
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                }
            }
        }
    }
}

#Preview { EditProfileView() }
