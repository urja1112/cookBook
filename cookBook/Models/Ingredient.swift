//
//  Ingredient.swift
//  cookBook
//
//  Created by urja 💙 on 2025-05-17.
//

import Foundation
import FirebaseFirestore

struct Ingredient : Identifiable,Codable,Equatable {
    @DocumentID var id : String?
    var userId: String?
    var name : String
    var quantity : String
    var expiryDate : Date
}
