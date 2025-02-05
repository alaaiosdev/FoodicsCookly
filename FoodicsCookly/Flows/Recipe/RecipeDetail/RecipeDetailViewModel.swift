//
//  RecipeDetailViewModel.swift
//  FoodicsCookly
//
//  Created by Alaa Abu-Taha on 05/02/2025.
//

import Foundation
import Combine

class RecipeDetailViewModel: ObservableObject {
    
    @Published private var recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
}

extension RecipeDetailViewModel {
    var image: String? {
        recipe.image
    }
    
    var name: String? {
        recipe.name
    }
    
    var cuisine: String? {
        recipe.cuisine
    }
    
    var prepTimeMinutes: Int? {
        recipe.prepTimeMinutes
    }
    
    var cookTimeMinutes: Int? {
        recipe.cookTimeMinutes
    }
}
