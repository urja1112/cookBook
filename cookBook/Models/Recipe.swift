//
//  Recipe.swift
//  cookBook
//
//  Created by urja 💙 on 2025-05-23.
//

import Foundation

struct Recipe : Identifiable,Codable {
    let id : Int
    let title : String
    let image : String?
    let usedIngredientCount: Int?
    let missedIngredientCount: Int?
}
