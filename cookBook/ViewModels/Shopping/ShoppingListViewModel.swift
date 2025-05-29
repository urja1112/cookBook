//
//  ShoppingListViewModel.swift
//  cookBook
//
//  Created by urja 💙 on 2025-05-28.
//


import Foundation
import FirebaseFirestore
import FirebaseAuth


class ShoppingListViewModel : ObservableObject {
    @Published var items: [ShoppingItem] = []


    private var db = Firestore.firestore()
    private var collection = "shoppingitem"
    
    var groupedItems: [String: [ShoppingItem]] {
        Dictionary(grouping: items) { item in
            item.recipeTitle ?? "Uncategorized"
        }
    }

    
    func fetchItem(completion : (()-> Void)? = nil) {
        guard let uid = Auth.auth().currentUser?.uid else {
              print("No logged-in user")
              return
          }
        db.collection("users").document(uid).collection("shoppingItems").addSnapshotListener {  snapshot, error in
            if let error = error {
                         print("❌ Failed to fetch: \(error)")
                         return
            }
            guard let documents = snapshot?.documents else { return }

            DispatchQueue.main.async {
                       self.items = documents.compactMap { doc in
                           try? doc.data(as: ShoppingItem.self)
                    }
            }
            
        }
    }
    
    func addItem(_ item : ShoppingItem) {
        var items = item
        guard let uid = Auth.auth().currentUser?.uid else {
              print("No logged-in user")
              return
          }
        let userRef = db.collection("users").document(uid).collection("shoppingItems")
        let docRef = userRef.document(item.id)
        
        do {
            try docRef.setData(from: item)
           } catch {
               print("Error adding item: \(error)")
           }

    }
    
    
    func removeItem(_ item : ShoppingItem) {
        print("🧾 Attempting to delete: \(item.name), id: \(item.id)")

        guard let uid = Auth.auth().currentUser?.uid else {
              print("No logged-in user")
              return
          }
        let docRef =  db.collection("users").document(uid).collection("shoppingItems").document(item.id)
        
        docRef.delete { error in
            if let error = error {
                print("❌ Failed to delete item: \(error.localizedDescription)")
            } else {
                print("✅ Item deleted")

            }
        }
        
    }

    
    func toggleItem(_ item : ShoppingItem) {
        guard let uid = Auth.auth().currentUser?.uid else {
              print("No logged-in user")
              return
          }
        let docRef = db.collection("users")
                          .document(uid)
                          .collection("shoppingItems")
                          .document(item.id)
        
        docRef.updateData([
            "isChecked": !item.isChecked
        ]) { error in
            if let error = error {
                print("❌ Toggle failed: \(error)")
            } else {
                print("✅ Toggled item: \(item.name)")
            }
        }
    }
    
    func clearList() {
        guard let uid = Auth.auth().currentUser?.uid else {
              print("No logged-in user")
              return
          }
        
        let batch = db.batch()
        let collection = db.collection("users").document(uid).collection("shoppingItems")
        
        for item in items {
            let docRef = collection.document(item.id)
            batch.deleteDocument(docRef)
        }
        batch.commit { error in
            if let error = error {
                print("❌ Failed to clear: \(error)")
            } else {
                print("🧹 Shopping list cleared")
            }
        }
    }
}
