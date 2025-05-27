//
//  RecipeAPIService.swiftso
//  CookMate
//
//  Created by urja 💙 on 2025-05-16.
//

import Foundation


class RecipeAPIService {
    static let shared = RecipeAPIService()
    
    private let apiKey = "7ad41a94de044cef800de69bb47a8388"
    
    func fetchRecipes(ingredients: [String]) async throws -> [Recipe] {
        let query = ingredients.joined(separator: ",")
        guard let url = URL(string: "https://api.spoonacular.com/recipes/findByIngredients?ingredients=\(query)&number=10&apiKey=\(apiKey)") else {
                  throw URLError(.badURL)
        }
        let (data,_) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode([Recipe].self, from: data)
        return decoded

    }
}
