//
//  MockRecipeService.swift
//  FoodicsCooklyTests
//
//  Created by Alaa Abu-Taha on 05/02/2025.
//

import Foundation
@testable import FoodicsCookly

class MockRecipeService: RecipeServiceProtocol {
    var mockFetchRecipesResponse: [Recipe]?
    var mockFetchError: Error?
    
    var mockSearchResponse: [Recipe]?
    var mockSearchError: Error?
    
    var mockSortResponse: [Recipe]?
    
    func fetchRecipes(with params: Parameter) async throws -> [Recipe]? {
        if let error = mockFetchError {
            throw error
        }
        return mockFetchRecipesResponse
    }
    
    func searchRecipes(text: String) async throws -> [Recipe]? {
        if let error = mockSearchError {
            throw error
        }
        return mockSearchResponse
    }
    
    func sortRecipes(sortBy: String, order: String) async throws -> [Recipe]? {
        return mockSortResponse
    }
}
