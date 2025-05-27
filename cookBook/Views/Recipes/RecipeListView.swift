//
//  RecipeListView.swift
//  CookMate
//
//  Created by urja 💙 on 2025-05-16.
//

import SwiftUI

struct RecipeListView: View {
    @EnvironmentObject var fridgeVM: IngredientViewModel
    @StateObject var recipeVM = RecipeListViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                if recipeVM.isLoading {
                    ProgressView("Fetching recipes...")
                }
                else if let error = recipeVM.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                } else if recipeVM.recipes.isEmpty {
                    Text("No recipes found. Try adding more ingredients.")
                        .foregroundColor(.gray)
                }
                else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(recipeVM.recipes) { recipe in
                                NavigationLink(destination: RecipeDetailView(id: recipe.id)) {
                                    RecipeView(recipe: recipe)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding()
                    }
                
                }
            }
            .navigationTitle("Recipe List")
            .onAppear {
                fridgeVM.fetchIngredients {
                    let ingredientNames = fridgeVM.ingredient.map { $0.name.lowercased() }
                    Task {
                        await recipeVM.loadRecipe(from: ingredientNames)
                    }
                }
            }
        }
    }
}

#Preview {
    RecipeListView()
          .environmentObject(IngredientViewModel())
}
