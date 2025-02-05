//
//  FoodicsCooklyApp.swift
//  FoodicsCookly
//
//  Created by Alaa Abu-Taha on 04/02/2025.
//

import SwiftUI

@main
struct FoodicsCooklyApp: App {
    var body: some Scene {
        WindowGroup {
            RecipeListView(viewModel: RecipeListViewModel(recipeService: APIRecipeService()))
        }
    }
}
