//
//  RecipeDetail.swift
//  cookBook
//
//  Created by urja 💙 on 2025-05-26.
//

import Foundation

struct RecipeDetail: Identifiable, Codable {
    let id: Int
    let title: String
    let image: String?
    let instructions: String?
    let sourceUrl: String?
    let extendedIngredients: [IngredientDetail]?
    //let usedIngredients : [IngredientDetail]
}

struct IngredientDetail: Codable, Identifiable {
    var id: Int { name.hashValue }
    let name: String
    let amount: Double?
    let unit: String?
}
