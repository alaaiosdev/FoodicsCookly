//
//  RecipeDetailViewModelTests.swift
//  FoodicsCooklyTests
//
//  Created by Alaa Abu-Taha on 05/02/2025.
//

import XCTest
@testable import FoodicsCookly

final class RecipeDetailViewModelTests: XCTestCase {
    var viewModel: RecipeDetailViewModel!
    var testRecipe: Recipe!

    override func setUp() {
        super.setUp()
        testRecipe = Recipe(
            id: 1,
            name: "Spaghetti Carbonara",
            ingredients: [],
            instructions: [],
            prepTimeMinutes: 15,
            cookTimeMinutes: 20,
            servings: 2,
            difficulty: "Medium",
            cuisine: "Italian",
            caloriesPerServing: 450,
            tags: [],
            userID: 1,
            image: "https://example.com/spaghetti.jpg",
            rating: 4.7,
            reviewCount: 120,
            mealType: []
        )
        viewModel = RecipeDetailViewModel(recipe: testRecipe)
    }

    override func tearDown() {
        viewModel = nil
        testRecipe = nil
        super.tearDown()
    }

    func testViewModel_Initialization() {
        XCTAssertEqual(viewModel.name, "Spaghetti Carbonara")
        XCTAssertEqual(viewModel.cuisine, "Italian")
        XCTAssertEqual(viewModel.image, "https://example.com/spaghetti.jpg")
    }

    func testViewModel_Properties() {
        XCTAssertNotNil(viewModel.image)
        XCTAssertEqual(viewModel.image, testRecipe.image)
        
        XCTAssertNotNil(viewModel.name)
        XCTAssertEqual(viewModel.name, testRecipe.name)
        
        XCTAssertNotNil(viewModel.cuisine)
        XCTAssertEqual(viewModel.cuisine, testRecipe.cuisine)
    }
}
