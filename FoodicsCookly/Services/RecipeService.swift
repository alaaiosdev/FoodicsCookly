//
//  RecipeService.swift
//  FoodicsCookly
//
//  Created by Alaa Abu-Taha on 04/02/2025.
//

import Foundation

protocol RecipeServiceProtocol {
    func fetchRecipes(with params: Parameter) async throws -> [Recipe]?
    func searchRecipes(text: String) async throws -> [Recipe]?
    func sortRecipes(sortBy: String, order: String) async throws -> [Recipe]?
}

public final class APIRecipeService {
    private var apiClient: APIClient
    
    init(apiClient: APIClient = APIClient()) {
        self.apiClient = apiClient
    }
}

private extension APIRecipeService {
    enum Path {
        fileprivate static let recipes = "recipes"
        fileprivate static let search = "\(recipes)/search?q=%@"
        fileprivate static let sort = "\(recipes)?sortBy=%@&order=%@"
    }
}

extension APIRecipeService: RecipeServiceProtocol {
    func fetchRecipes(with params: Parameter = Parameter()) async throws -> [Recipe]? {
        let response: RecipeResponse = try await apiClient.performRequest(
            endpoint: Path.recipes,
            parameters: ["limit": params.limit, "skip": params.skip])
        
        return response.recipes
    }
    
    func searchRecipes(text: String) async throws -> [Recipe]? {
        let encodedText = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let endpoint = String(format: Path.search, encodedText)
        let response: RecipeResponse = try await apiClient.performRequest(endpoint: endpoint)
        return response.recipes
    }
    
    func sortRecipes(sortBy: String, order: String) async throws -> [Recipe]? {
        let endpoint = String(format: Path.sort, sortBy, order)
        let response: RecipeResponse = try await apiClient.performRequest(endpoint: endpoint)
        return response.recipes
    }
}
