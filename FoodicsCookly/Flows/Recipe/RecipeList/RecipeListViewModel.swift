//
//  RecipeListViewModel.swift
//  FoodicsCookly
//
//  Created by Alaa Abu-Taha on 04/02/2025.
//

import Foundation
import Combine

class RecipeListViewModel: ObservableObject {
    @Published private(set) var recipes: [Recipe] = []
    @Published private(set) var filteredRecipes: [Recipe] = []
    @Published private(set) var loadingState: LoadingState = .idle
    @Published var searchQuery: String = ""
    private var cancellables = Set<AnyCancellable>()
    
    private var isFetching = false
    private var hasMoreData = true
    private var params: Parameter = Parameter()
    private let recipeService: RecipeServiceProtocol
    
    init(recipeService: RecipeServiceProtocol) {
        self.recipeService = recipeService
        reloadData()
        setupBinding()
    }
}

extension RecipeListViewModel {
    func reloadData() {
        params.skip = 0
        recipes.removeAll()
        hasMoreData = true
        
        Task { await fetchRecipes() }
    }
    
    func setupBinding() {
        $searchQuery
            .removeDuplicates()
            .sink { [weak self] query in
                Task { [weak self] in
                    await self?.searchRecipes(query: query)
                }
            }
            .store(in: &cancellables)
    }
    
    func loadMoreIfNeeded(currentItem: Recipe) {
        guard let lastItem = recipes.last, lastItem.id == currentItem.id else { return }
        Task { await fetchRecipes() }
    }
    
    func sortBy() {
        Task { await sortRecipes(sortBy: "name", order: "asc") }
    }
    
    func toggleOrder() {
        let currentOrder = params.order.rawValue == "asc" ? "desc" : "asc"
        params.order = Order(rawValue: currentOrder) ?? .asc
        Task { await sortRecipes(sortBy: "name", order: currentOrder) }
    }
}

extension RecipeListViewModel {
    @MainActor
    func fetchRecipes() {
        guard !isFetching, hasMoreData else { return }
        
        isFetching = true
        loadingState = .loading
        
        Task {
            do {
                if let newRecipes = try await recipeService.fetchRecipes(with: params), !newRecipes.isEmpty {
                    recipes.append(contentsOf: newRecipes)
                    filteredRecipes = recipes
                    params.skip += params.limit
                } else {
                    hasMoreData = false
                }
                loadingState = .idle
            } catch {
                loadingState = .error(error.localizedDescription)
            }
            isFetching = false
        }
    }
    
    @MainActor
    func searchRecipes(query: String) async {
        guard !query.isEmpty else {
            filteredRecipes = recipes
            return
        }
        loadingState = .loading
        do {
            recipes = try await recipeService.searchRecipes(text: query) ?? []
            filteredRecipes = recipes
            loadingState = .idle
        } catch {
            loadingState = .error(error.localizedDescription)
        }
    }
    
    @MainActor
    func sortRecipes(sortBy: String, order: String) {
        Task {
            do {
                if let sortedRecipes = try await recipeService.sortRecipes(sortBy: sortBy, order: order) {
                    recipes = sortedRecipes
                    filteredRecipes = sortedRecipes
                }
            } catch {
                loadingState = .error(error.localizedDescription)
            }
        }
    }
}
