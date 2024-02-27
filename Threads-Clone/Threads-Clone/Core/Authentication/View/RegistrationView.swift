//
//  RegistrationView.swift
//  Threads-Clone
//
//  Created by Anton Gerasimov on 20.02.2024.
//

import SwiftUI

struct RegistrationView: View {
    @State var viewModel = RegistrationViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("threads-icon")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .padding()
            
            VStack {
                TextField("Enter your email", text: $viewModel.email)
                    .modifier(ThreadsTextFieldModifier())
                
                
                SecureField("Enter your password", text: $viewModel.password)                      .modifier(ThreadsTextFieldModifier())
                
                TextField("Enter your full name", text: $viewModel.fullName)
                    .modifier(ThreadsTextFieldModifier())
                
                TextField("Enter your user name", text: $viewModel.userName)
                    .modifier(ThreadsTextFieldModifier())
            }
            
            Button {
                Task { try await viewModel.createUser() }
            } label: {
                Text("Sing Up")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 352, height: 44)
                    .background(.black)
                    .cornerRadius(8)
            }
            .padding(.vertical)
            
            Spacer()
            
            Divider()
            
            Button {
                
            } label: {
                HStack(spacing: 3) {
                    Text("Already have an account?")
                    
                    Text("Sing In")
                        .fontWeight(.semibold)
                }
                .foregroundColor(.black)
                .font(.footnote)
            }
            .padding(.vertical, 16)
        }
    }
}

#Preview {
    RegistrationView()
}
