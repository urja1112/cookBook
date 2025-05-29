//
//  ShoppingListView.swift
//  CookMate
//
//  Created by urja 💙 on 2025-05-16.
//

import SwiftUI

struct ShoppingListView: View {
    @EnvironmentObject var viewModel: ShoppingListViewModel
    
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.items.isEmpty {
                    Text("🛒 Your shopping list is empty.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(viewModel.groupedItems.keys.sorted(), id : \.self) { recipeTitle in
                            
                            Section(header: Text(recipeTitle).font(.headline)) {
                                let group = viewModel.groupedItems[recipeTitle] ?? []

                                ForEach(group) { item in
                                    HStack {
                                        Button(action: {
                                            viewModel.toggleItem(item)
                                        }) {
                                            Image(systemName: item.isChecked ? "checkmark.circle.fill" : "circle")
                                                .foregroundColor(item.isChecked ? .green : .gray)
                                        }
                                        VStack(alignment: .leading){
                                            Text(item.name)
                                                .strikethrough(item.isChecked, color: .gray)
                                            Text(item.quantity)
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                }
                                .onDelete { indexSet in
                                    for index in indexSet {
                                        if index < group.count {
                                            let item = group[index]
                                            viewModel.removeItem(item)
                                        }
                                    }
                                }
                            }
                        }
                  
                        
                        Button("🧹 Clear All") {
                            viewModel.clearList()
                        }
                        .foregroundColor(.red)
                        .padding()
                    }
                    
                }
            }
            .onAppear() {
                viewModel.fetchItem()
            }
            .navigationTitle("Shopping List")
        }
    }
}

#Preview {
    ShoppingListView()
        .environmentObject(ShoppingListViewModel())

    
}
