//
//  RecipeListViewModel.swift
//  FoodicsCookly
//
//  Created by Alaa Abu-Taha on 04/02/2025.
//

import Foundation
import Combine

//class RecipeListViewModel: ObservableObject {
//    @Published private(set) var recipes: [Recipe] = []
//    @Published private(set) var loadingState: LoadingState = .idle
//    
//    private let recipeService: RecipeServiceProtocol
//    
//    init(recipeService: RecipeServiceProtocol) {
//        self.recipeService = recipeService
//        reloadData()
//    }
//    
//    func reloadData() {
//        Task { await fetchRecipes() }
//    }
//}
//
//private extension RecipeListViewModel {
//    @MainActor
//    func fetchRecipes() async {
//        loadingState = .loading
//        do {
//            recipes = try await recipeService.fetchRecipes() ?? []
//            loadingState = .idle
//        } catch {
//            loadingState = .error(error.localizedDescription)
//        }
//    }
//}

class RecipeListViewModel: ObservableObject {
    @Published private(set) var recipes: [Recipe] = []
    @Published private(set) var filteredRecipes: [Recipe] = []
    @Published private(set) var loadingState: LoadingState = .idle
    
    private let recipeService: RecipeServiceProtocol
    
    init(recipeService: RecipeServiceProtocol) {
        self.recipeService = recipeService
        reloadData()
    }
    
    func reloadData() {
        Task { await fetchRecipes() }
    }
    
    func filterRecipes(query: String) {
        if query.isEmpty {
            filteredRecipes = recipes
        } else {
            filteredRecipes = recipes.filter { $0.name?.localizedCaseInsensitiveContains(query) ?? false }
        }
    }
    
    func sortRecipes(by option: SortOption) {
        switch option {
        case .rating:
            filteredRecipes = recipes
            filteredRecipes.sort { ($0.rating ?? 0) > ($1.rating ?? 0) }
        case .deliveryFree:
            filteredRecipes = filteredRecipes.filter { ($0.cookTimeMinutes ?? 0) == 0 }
        }
    }
}

private extension RecipeListViewModel {
    @MainActor
    func fetchRecipes() async {
        loadingState = .loading
        do {
            recipes = try await recipeService.fetchRecipes() ?? []
            filteredRecipes = recipes
            loadingState = .idle
        } catch {
            loadingState = .error(error.localizedDescription)
        }
    }
}
