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

    func fetchIngredients(completion: (() -> Void)? = nil) {
        db.collection(collection)
            .whereField("userId", isEqualTo: Auth.auth().currentUser?.uid)
            .order(by: "expiryDate")
            .addSnapshotListener { snapshot, error in
                guard let documents = snapshot?.documents else {
                    completion?()
                    return
                }
                self.ingredient = documents.compactMap { doc in
                    try? doc.data(as: Ingredient.self)
                }
                completion?()
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
    
    func updateIngredient(ingredient: Ingredient,name : String , quantity : String, expiryDate : Date) {
        guard let userId = Auth.auth().currentUser?.uid else {
             print("❌ No user ID found")
             return
         }

         guard let id = ingredient.id else {
             print("❌ Ingredient missing document ID")
             return
         }

         let updatedIngredient = Ingredient(
             id: id,
             userId: userId, name: name,
             quantity: quantity,
             expiryDate: expiryDate
         )
        
        do {
            try db.collection(collection)
                .document(id)
                .setData(from: updatedIngredient,merge: true) { error in
                    if let error = error {
                        print("❌ Failed to update ingredient: \(error.localizedDescription)")
                    } else {
                        print("✅ Ingredient updated successfully")
                            }
                    }
            if let index = self.ingredient.firstIndex(where: { $0.id == id }) {
                     self.ingredient[index] = updatedIngredient
                 }
        } catch {
            print("❌ Firestore encoding error: \(error.localizedDescription)")

        }
    }
}
