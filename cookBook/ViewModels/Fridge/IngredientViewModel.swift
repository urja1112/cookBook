//
//  IngredientViewModel.swift
//  cookBook
//
//  Created by urja 💙 on 2025-05-17.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class IngredientViewModel : ObservableObject {
    @Published var ingredient : [Ingredient] = []
    @Published var shouldRefresh = false

    
    private var db = Firestore.firestore()
    private var collection = "ingredients"

    
    func fetchIngredients() {
        db.collection(collection)
            .whereField("userId", isEqualTo: Auth.auth().currentUser?.uid)
            .order(by: "expiryDate").addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else {return}
            self.ingredient = documents.compactMap{ doc in
                try? doc.data(as: Ingredient.self)
            }
        }
    }
    
    func addIngredient(_ ingredient : Ingredient) {
        var ingredient = ingredient // make a mutable copy
        ingredient.userId = Auth.auth().currentUser?.uid

        do {
            _ = try db.collection(collection).addDocument(from: ingredient)
        } catch {
            print("Error adding: \(error)")

        }
    }
    func deleteIngredient(_ ingredient: Ingredient) {
        guard let id = ingredient.id else { return }
        db.collection("ingredients").document(id).delete { error in
            if let error = error {
                print("Error deleting: \(error)")
            }
        }
    }
}
