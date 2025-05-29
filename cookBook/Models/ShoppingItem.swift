//
//  Shopping.swift
//  cookBook
//
//  Created by urja 💙 on 2025-05-28.
//

import Foundation

struct ShoppingItem : Identifiable,Codable,Equatable {
    var id : String = UUID().uuidString
    var name : String
    var quantity : String
    var isChecked : Bool
    var recipeTitle: String? // 🆕

}
