//
//  RecipeServiceTests.swift
//  FoodicsCooklyTests
//
//  Created by Alaa Abu-Taha on 04/02/2025.
//

import XCTest
@testable import FoodicsCookly

final class APIRecipeServiceTests: XCTestCase {
    var mockAPIClient: MockAPIClient!
    var apiRecipeService: APIRecipeService!
    
    override func setUp() {
        super.setUp()
        mockAPIClient = MockAPIClient()
        apiRecipeService = APIRecipeService(apiClient: mockAPIClient)
    }
    
    override func tearDown() {
        mockAPIClient = nil
        apiRecipeService = nil
        super.tearDown()
    }
    
    func testFetchRecipes_Success() async throws {
        let jsonString = """
        {
            "recipes": [
                {
                    "id": 1,
                    "name": "Classic Margherita Pizza",
                    "ingredients": ["Pizza dough", "Tomato sauce"],
                    "instructions": ["Preheat the oven to 475°F (245°C).", "Roll out the pizza dough and spread tomato sauce evenly."],
                    "prepTimeMinutes": 20,
                    "cookTimeMinutes": 15,
                    "servings": 4,
                    "difficulty": "Easy",
                    "cuisine": "Italian",
                    "caloriesPerServing": 300,
                    "tags": ["Pizza","Italian"],
                    "userId": 166,
                    "image": "https://cdn.dummyjson.com/recipe-images/1.webp",
                    "rating": 4.6,
                    "reviewCount": 98,
                    "mealType": ["Dinner"]
                }
            ],
            "total": 1,
            "skip": 0,
            "limit": 10
        }
        """
        
        mockAPIClient.mockData = jsonString.data(using: .utf8)
        
        do {
            let recipes = try await apiRecipeService.fetchRecipes()
            XCTAssertNotNil(recipes)
            XCTAssertEqual(recipes?.count, 1)
            XCTAssertEqual(recipes?.first?.name, "Classic Margherita Pizza")
        } catch {
            XCTFail("Expected success but got error: \(error)")
        }
    }
    
    func testFetchRecipes_Failure_InvalidResponse() async throws {
        mockAPIClient.mockData = nil
        
        do {
            _ = try await apiRecipeService.fetchRecipes()
            XCTFail("Expected failure but got success")
        } catch APIError.invalidResponse {
            XCTAssertTrue(true)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
