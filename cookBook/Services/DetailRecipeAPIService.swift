//
//  DetailRecipeAPIService.swift
//  cookBook
//
//  Created by urja 💙 on 2025-05-26.
//


import Foundation
class DetailRecipeAPIService {
    static let shared = DetailRecipeAPIService()
    private let baseURL = "https://api.spoonacular.com"
    private let apiKey = "7ad41a94de044cef800de69bb47a8388"
    func fetchRecipeDetail(id : Int) async throws -> RecipeDetail {
        let urlString = "\(baseURL)/recipes/\(id)/information?includeNutrition=false&apiKey=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
            
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
                    200..<300 ~= httpResponse.statusCode else {
                  throw URLError(.badServerResponse)
              }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        print(try decoder.decode(RecipeDetail.self, from: data).sourceUrl)
        

        return try decoder.decode(RecipeDetail.self, from: data)

        }
}


