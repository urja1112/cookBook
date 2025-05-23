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
    @State private var name = ""
    @State private var quantity = ""
    @State private var expiryDate = Date()
    @Environment(\.dismiss) var dismiss


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
            .navigationTitle("Add Ingredient")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        var newIngredient = Ingredient(name: name, quantity: quantity, expiryDate: expiryDate)
                        newIngredient.userId = Auth.auth().currentUser?.uid
                        viewModel.addIngredient(newIngredient)
                        viewModel.shouldRefresh = true
                        dismiss()
                        
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                        }
                }
            }
        }
    }
}

#Preview {
    AddIngredientView(viewModel: IngredientViewModel())
}
