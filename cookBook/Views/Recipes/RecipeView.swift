//
//  RecipeView.swift
//  cookBook
//
//  Created by urja 💙 on 2025-05-26.
//

import SwiftUI

struct RecipeView: View {
    let recipe: Recipe

     var body: some View {
         VStack(alignment: .leading, spacing: 8) {
             Text(recipe.title)
                 .font(.headline)

             if let image = recipe.image,
                let url = URL(string: image) {
                 AsyncImage(url: url) { phase in
                     if let img = phase.image {
                         img.resizable()
                             .scaledToFill()
                             .frame(height: 140)
                             .clipped()
                             .cornerRadius(10)
                     } else {
                         Color.gray.frame(height: 140)
                             .cornerRadius(10)
                     }
                 }
             }
             

             Text("Used: \(recipe.usedIngredientCount ?? 0), Missing: \(recipe.missedIngredientCount ?? 0)")
                 .font(.caption)
                 //.foregroundColor(.secondary)
         }
         .padding()
         .background(RoundedRectangle(cornerRadius: 16).fill(Color(.systemBackground)))
         .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 2)

         //.padding(.vertical, 8)
     }
}

#Preview {
    RecipeView(recipe:  Recipe(
        id: 123,
        title: "Veggie Tacos",
        image: "https://spoonacular.com/recipeImages/716429-556x370.jpg",
        usedIngredientCount: 4,
        missedIngredientCount: 2
    ))
}
