//
//  RecipeDetailView.swift
//  CookMate
//
//  Created by urja 💙 on 2025-05-16.
//

import SwiftUI

struct RecipeDetailView: View {
    @StateObject private var viewModel = RecipeDetailViewModel()

    var id : Int
    var body: some View {
           ScrollView {
               if viewModel.isLoading {
                   ProgressView("Loading recipe...")
               } else if let recipe = viewModel.recipeDetail {
                   VStack(alignment: .leading, spacing: 16) {
                       Text(recipe.title)
                           .font(.largeTitle)
                           .bold()

                       if let imageUrl = URL(string: recipe.image ?? "") {
                           AsyncImage(url: imageUrl) { phase in
                               if let image = phase.image {
                                   image
                                       .resizable()
                                       .aspectRatio(contentMode: .fit)
                                       .cornerRadius(12)
                               } else {
                                   Color.gray.frame(height: 200)
                               }
                           }
                       }



                       if let instructions = recipe.instructions, !instructions.isEmpty {
                           Text("📝 Instructions")
                               .font(.headline)
                           Text(instructions)
                       }

                       if let source = recipe.sourceUrl,
                          let url = URL(string: source),
                          UIApplication.shared.canOpenURL(url) {
                           
                           Link("🔗 Full Recipe", destination: url)
                               .padding(.top)
                               .foregroundColor(.blue)

                       } else {
                           Text("⚠️ Recipe link not available.")
                               .foregroundColor(.gray)
                       }
                   }
                   .padding()
               } else if let error = viewModel.errorMessage {
                   Text("Error: \(error)")
                       .foregroundColor(.red)
                   

               }
           }
           .navigationTitle("Recipe Details")
           .navigationBarTitleDisplayMode(.inline)
           .onAppear {
               Task {
                   await viewModel.loadRecipeDetail(id: id)
               }
           }
       }
}

#Preview {
    RecipeDetailView(id: 123)
}
