//
//  AddIngredientView.swift
//  CookMate
//
//  Created by urja 💙 on 2025-05-16.
//

import SwiftUI
import FirebaseAuth

struct AddIngredientView: View {
    @ObservedObject var viewModel: IngredientViewModel
    var existingIngredient: Ingredient? = nil
    @State private var name = ""
    @State private var quantity = ""
    @State private var expiryDate = Date()
    @Environment(\.dismiss) var dismiss
    @State private var editingIngredient: Ingredient? = nil



    init(viewModel: IngredientViewModel, existingIngredient: Ingredient? = nil) {
        self.viewModel = viewModel
        self.existingIngredient = existingIngredient

        if let ingredient = existingIngredient {
            _name = State(initialValue: ingredient.name)
            _quantity = State(initialValue: ingredient.quantity)
            _expiryDate = State(initialValue: ingredient.expiryDate)
        }
    }
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                
                Text("Ingredient Name")
                TextField("Ingredient Name", text: $name)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                Text("Quantity")
                TextField("Quantity", text: $quantity)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                Text("Expiry Date")

                DatePicker("Expiry Date", selection: $expiryDate, in: Date()..., displayedComponents: .date)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)

                
                Spacer()

            }
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding()
            .navigationTitle(existingIngredient?.id == nil ? "Add Ingredient" : "Edit Ingredient")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if let ingredient = existingIngredient, ingredient.id != nil {
                            // ✅ Update existing
                            viewModel.updateIngredient(
                                ingredient: ingredient,
                                name: name,
                                quantity: quantity,
                                expiryDate: expiryDate
                            )
                        } else {
                            // ✅ Add new
                            let newIngredient = Ingredient(
                                id: nil,
                                userId: nil,
                                name: name,
                                quantity: quantity,
                                expiryDate: expiryDate
                            )
                            viewModel.addIngredient(newIngredient)
                        }
                        dismiss()
                        
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                        }
                }
            }
//            .onAppear {
//                if let ingredient = existingIngredient {
//                    name = ingredient.name
//                    quantity = ingredient.quantity
//                    expiryDate = ingredient.expiryDate
//                }
//            }
        }
    }
}

#Preview {
    AddIngredientView(viewModel: IngredientViewModel())
}
