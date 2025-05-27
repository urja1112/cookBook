//
//  RecipeDetailViewModel.swift
//  cookBook
//
//  Created by urja 💙 on 2025-05-26.
//

import Foundation

class RecipeDetailViewModel : ObservableObject {
    @Published var recipeDetail: RecipeDetail?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func loadRecipeDetail(id : Int) async {
        isLoading = true
        errorMessage = nil
        do {
            let detail = try await DetailRecipeAPIService.shared.fetchRecipeDetail(id: id)
            DispatchQueue.main.async {
                self.recipeDetail = detail
                self.isLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
                }
        }
    }
}
