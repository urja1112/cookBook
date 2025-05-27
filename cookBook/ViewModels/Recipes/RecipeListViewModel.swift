//
//  RecipeListViewModel.swift
//  cookBook
//
//  Created by urja 💙 on 2025-05-23.
//

import Foundation

@MainActor
class RecipeListViewModel : ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func loadRecipe(from ingrident : [String]) async {
        isLoading = true
        errorMessage = nil
        do {
            let results = try await RecipeAPIService.shared.fetchRecipes(ingredients: ingrident)
            self.recipes = results
            
        } catch {
            self.errorMessage = error.localizedDescription

        }
        isLoading = false
    }
}
