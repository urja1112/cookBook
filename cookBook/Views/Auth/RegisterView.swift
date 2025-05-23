//
//  RegisterView.swift
//  CookMate
//
//  Created by urja 💙 on 2025-05-16.
//

import SwiftUI

struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
    @ObservedObject var viewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss

    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                
                Text("Email")
                TextField("Email", text: $email)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                Text("Password")
                SecureField("Password", text:  $password)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
          

                if let error = viewModel.errorMessage {
                    Text(error).foregroundColor(.red)
                    }
                
                Button("Register") {
                    viewModel.login(email: email, password: password)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.top)
                Spacer()
                
                VStack(alignment: .center) {
                    Text("Already have account")
                   // NavigationLink("Login", destination: LoginView())
                    Button("Login") {
                        dismiss()
                    }
                    .bold()
                }
                .frame(maxWidth: .infinity,alignment: .center)
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding()
            .navigationTitle("Register")
        }
    }
}

#Preview {
    RegisterView(viewModel: AuthViewModel())
}
