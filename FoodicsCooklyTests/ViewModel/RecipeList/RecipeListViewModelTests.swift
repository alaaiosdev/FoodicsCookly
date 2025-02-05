//
//  RecipeListViewModelTests.swift
//  FoodicsCooklyTests
//
//  Created by Alaa Abu-Taha on 05/02/2025.
//

import XCTest
import Combine
@testable import FoodicsCookly

class RecipeListViewModelTests: XCTestCase {
    
    var viewModel: RecipeListViewModel!
    var mockRecipeService: MockRecipeService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
        mockRecipeService = MockRecipeService()
        viewModel = RecipeListViewModel(recipeService: mockRecipeService)
    }
    
    override func tearDown() {
        cancellables = nil
        viewModel = nil
        mockRecipeService = nil
        super.tearDown()
    }
    
    func testInitialState() {
        XCTAssertTrue(viewModel.recipes.isEmpty)
        XCTAssertTrue(viewModel.filteredRecipes.isEmpty)
        XCTAssertEqual(viewModel.searchQuery, "")
    }
        
    func testSearchRecipesSuccess() async {
        let searchQuery = "pasta"
        let mockRecipes = [Recipe(id: 1, name: "Pasta Recipe", ingredients: [], instructions: [], prepTimeMinutes: 15, cookTimeMinutes: 25, servings: 4, difficulty: "Medium", cuisine: "Italian", caloriesPerServing: 350, tags: [], userID: 1, image: "", rating: 4.7, reviewCount: 50, mealType: ["Dinner"])]
        
        mockRecipeService.mockSearchResponse = mockRecipes
        
        viewModel.searchQuery = searchQuery
        
        await viewModel.searchRecipes(query: searchQuery)
        
        XCTAssertEqual(viewModel.filteredRecipes.count, 1)
        XCTAssertEqual(viewModel.filteredRecipes.first?.name, "Pasta Recipe")
    }
    
    func testSearchRecipesNoResults() async {
        let searchQuery = "nonexistent"
        mockRecipeService.mockSearchResponse = []
        
        viewModel.searchQuery = searchQuery
        
        await viewModel.searchRecipes(query: searchQuery)
        
        XCTAssertTrue(viewModel.filteredRecipes.isEmpty)
    }
}
