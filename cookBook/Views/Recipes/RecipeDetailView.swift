//
//  RecipeDetailView.swift
//  CookMate
//
//  Created by urja 💙 on 2025-05-16.
//

import SwiftUI

struct RecipeDetailView: View {
    @StateObject private var viewModel = RecipeDetailViewModel()
    @EnvironmentObject var shoppingVM: ShoppingListViewModel

    var id : Int
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
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
                    
                    Button( action : {
                        if let ingredients = recipe.extendedIngredients {
                            for ingredient in ingredients {
                                let quantity = "\(String(format: "%.1f", ingredient.amount ?? 0)) \(ingredient.unit ?? "")"
                                
                                let name = ingredient.name ?? "Unknown"
                                
                                let item = ShoppingItem(name: name, quantity: quantity, isChecked: false, recipeTitle : recipe.title)
                                shoppingVM.addItem(item)
                                
                            }
                            withAnimation {
                                viewModel.showToast = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    viewModel.showToast = false
                                }
                            }
                            
                        }
                    }) {
                        HStack {
                            Image(systemName: "cart.badge.plus")
                            Text("Add to Shopping List")
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(10)
                    }
                    
                    if let ingredients = recipe.extendedIngredients, !ingredients.isEmpty {
                        Text("🥕 Ingredients")
                            .font(.headline)
                        
                        ForEach(ingredients) { ingredient in
                            let quantity = String(format: "%.1f", ingredient.amount ?? 0)
                            Text("• \(quantity) \(ingredient.unit ?? "") \(ingredient.name ?? "")")
                                .font(.subheadline)
                        }
                        
                        // Text("\(ingredients)")
                    }
                    
                    
                    
                    
                    if let instructions = recipe.instructions, !instructions.isEmpty {
                        //                           Text("📝 Instructions")
                        //                               .font(.headline)
                        //                           Text(instructions)
                        
                        Text("📝 Instructions")
                            .font(.headline)
                        
                        let steps = instructions.components(separatedBy: ". ").filter { !$0.isEmpty }
                        ForEach(steps.indices, id: \.self) { i in
                            Text("\(i + 1). \(steps[i])")
                                .padding(.bottom, 2)
                        }
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
    }
        .padding()
        .overlay(
            Group {
                if viewModel.showToast {
                    Text("✅ Added to shopping list")
                        .padding()
                        .background(Color.black.opacity(0.75))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .transition(.opacity)
                }
            },
            alignment: .top
        )
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
        .environmentObject(ShoppingListViewModel())
}
