//
//  AuthService.swift
//  CookMate
//
//  Created by urja 💙 on 2025-05-16.
//

import Foundation
import FirebaseAuth


class AuthService : ObservableObject {
    static let shared = AuthService()
    
    
    func login(email : String,password : String,completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    func register(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    func logout() {
        try? Auth.auth().signOut()
    }

    func isUserLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
}
