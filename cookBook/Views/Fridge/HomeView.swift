//
//  HomeView.swift
//  CookMate
//
//  Created by urja 💙 on 2025-05-16.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = IngredientViewModel()
    @State private var showingAddsheet = false

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
                            VStack(alignment: .leading) {
                                Text(ingredient.name).font(.headline)
                                Text("Qty: \(ingredient.quantity)")
                                Text("Expires: \(ingredient.expiryDate, style: .date)")
                                    .foregroundColor(ingredient.expiryDate < Date() ? .red : .secondary)
                            }
                        }
                        .onDelete { indexset in
                            indexset.map { viewModel.ingredient[$0] }.forEach(viewModel.deleteIngredient)
                           // viewModel.shouldRefresh = true
                        }
                    }
                    
                }
            }
            .navigationTitle("My Fridge")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                             Button(action: {
                                 showingAddsheet = true
                             }) {
                                 Image(systemName: "plus")
                             }
                         }
                    }
          
            .sheet(isPresented: $showingAddsheet) {
                AddIngredientView(viewModel: viewModel)
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
    HomeView()
}
