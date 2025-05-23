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
    
    
    func login(email : String , password : String ) {
        AuthService.shared.login(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success :
                    self.isLoggedIn = true
                case .failure(let error) :
                    self.errorMessage = error.localizedDescription
                    
                }
                
            }
        }
    }
    
    func register(email : String,password : String){
        AuthService.shared.register(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success :
                    self.isLoggedIn = true
                case .failure(let error) :
                    self.errorMessage = error.localizedDescription
                    
                }
                
            }
        }
    }
    
    func logout() {
        AuthService.shared.logout()
        isLoggedIn = false
    }
}
