//
//  Recipe.swift
//  FoodicsCookly
//
//  Created by Alaa Abu-Taha on 04/02/2025.
//

import Foundation

struct Recipe: Identifiable, Hashable, Codable {
    let id: Int?
    let name: String?
    let ingredients, instructions: [String]?
    let prepTimeMinutes, cookTimeMinutes, servings: Int?
    let difficulty: String?
    let cuisine: String?
    let caloriesPerServing: Int?
    let tags: [String]?
    let userID: Int?
    let image: String?
    let rating: Double?
    let reviewCount: Int?
    let mealType: [String]?

    enum CodingKeys: String, CodingKey {
        case id, name, ingredients, instructions, prepTimeMinutes, cookTimeMinutes, servings, difficulty, cuisine, caloriesPerServing, tags
        case userID = "userId"
        case image, rating, reviewCount, mealType
    }
}

struct RecipeResponse: Codable {
    let recipes: [Recipe]?
    let total, skip, limit: Int?
}
