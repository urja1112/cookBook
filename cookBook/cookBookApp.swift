//
//  cookBookApp.swift
//  cookBook
//
//  Created by urja 💙 on 2025-05-17.
//

import SwiftUI
import Firebase

@main
struct cookBookApp: App {
    @StateObject private var authViewModel = AuthViewModel()

    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            if authViewModel.isLoggedIn || AuthService.shared.isUserLoggedIn() {
                MainTabView()
                    .environmentObject(authViewModel)
                    .environmentObject(IngredientViewModel())
                    .transition(.move(edge: .trailing))

            } else {
                LoginView(viewModel: authViewModel)
                    .transition(.move(edge: .leading))

            }

        }

    }
}
