//
//  MainTabView.swift
//  cookBook
//
//  Created by urja 💙 on 2025-05-23.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView(authmodel: AuthViewModel())
                .tabItem {
                    Label("Fridge", systemImage: "cube")
                    }
            RecipeListView()
                .tabItem {
                    Label("Recipes",systemImage: "book")
                }
            ShoppingListView()
                           .tabItem {
                               Label("Shopping", systemImage: "cart")
                           }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                    }
            

            
        }
    }
}

#Preview {
    MainTabView()
}
