//
//  FirestoreService.swift
//  CookMate
//
//  Created by urja 💙 on 2025-05-16.
//

import Foundation

class SecretsManager {
    static let shared = SecretsManager()
    
    private var secrets: [String: Any] = [:]
    
    private init() {
        if let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: path) as? [String: Any] {
            self.secrets = dict
        }
    }
    
    var apiKey: String {
        return secrets["API_KEY"] as? String ?? ""
    }
}
