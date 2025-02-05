//
//  RecipeDetailView.swift
//  FoodicsCookly
//
//  Created by Alaa Abu-Taha on 04/02/2025.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                if let imageUrl = recipe.image, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(maxWidth: .infinity, maxHeight: 300)
                }
                
                Text(recipe.name ?? "")
                    .font(.largeTitle)
                    .bold()
                
                Text(recipe.cuisine ?? "")
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle("Recipe Detail")
    }
}
