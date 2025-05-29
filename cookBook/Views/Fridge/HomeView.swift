//
//  HomeView.swift
//  CookMate
//
//  Created by urja 💙 on 2025-05-16.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = IngredientViewModel()
    @ObservedObject var authmodel: AuthViewModel
    @State private var selectedIngredient: Ingredient?

    var body: some View {
        NavigationStack {
            Group {
                if(viewModel.ingredient.isEmpty) {
                    Text("Please press + to add Ingredient")
                        .bold()
                        .fontWeight(.heavy)
                }
                else {
                    List {
                        ForEach(viewModel.ingredient) { ingredient in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(ingredient.name).font(.headline)
                                    Text("Qty: \(ingredient.quantity)")
                                    Text("Expires: \(ingredient.expiryDate, style: .date)")
                                        .foregroundColor(ingredient.expiryDate < Date() ? .red : .secondary)
                                }
                                Spacer() // 🔑 Forces HStack to fill full width
                            }
                            .contentShape(Rectangle()) // 🔑 Makes full row tappable
                            .onTapGesture {
                                selectedIngredient = ingredient
                            }
                        }
                        .onDelete { indexset in
                            indexset.map { viewModel.ingredient[$0] }.forEach(viewModel.deleteIngredient)
                        }
                    }
                    
                }
            }
            .navigationTitle("My Fridge")
            .navigationBarTitleDisplayMode(.large)
           
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        selectedIngredient = Ingredient(id: nil, userId: nil, name: "", quantity: "", expiryDate: Date())
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
          
            .sheet(item: $selectedIngredient) { ingredient in
                AddIngredientView(viewModel: viewModel, existingIngredient: ingredient)
            }
            .onAppear {
                          viewModel.fetchIngredients()
                }
                .onChange(of: viewModel.shouldRefresh) { newValue in
                    if newValue {
                        viewModel.fetchIngredients()
                        viewModel.shouldRefresh = false
                        }
                }
            
            }
        
        }
    
}

#Preview {
    HomeView( authmodel: AuthViewModel())
}
