//
//  AuthViewModel.swift
//  CookMate
//
//  Created by urja 💙 on 2025-05-17.
//

import Foundation
import FirebaseAuth

class AuthViewModel : ObservableObject {
    @Published var isLoggedIn = false
    @Published var errorMessage: String?
    @Published var isLoading = false

    var currentUser: User? {
        return Auth.auth().currentUser
    }
    
    init() {
        // Automatically restore session on app launch
        self.isLoggedIn = Auth.auth().currentUser != nil
    }

    
    func login(email : String , password : String ) {
        errorMessage = nil
        isLoading.toggle()
        AuthService.shared.login(email: email, password: password) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success :
                    self.isLoggedIn = true
                case .failure(let error) :
                    self.errorMessage = error.localizedDescription
                    self.isLoggedIn = false
                    
                }
                
            }
        }
    }
    
    func register(email : String,password : String){
        errorMessage = nil
        isLoading.toggle()
        AuthService.shared.register(email: email, password: password) { result in
            DispatchQueue.main.async {
                self.isLoading = false

                switch result {
                    
                case .success :
                    self.isLoggedIn = true
                case .failure(let error) :
                    self.errorMessage = error.localizedDescription
                    self.isLoggedIn = false

                    
                }
                
            }
        }
    }
    
    func logout() {
        AuthService.shared.logout()
        isLoggedIn = false
    }
}
