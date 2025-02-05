//
//  RecipeRowView.swift
//  FoodicsCookly
//
//  Created by Alaa Abu-Taha on 05/02/2025.
//

import SwiftUI

struct RecipeRowView: View {
    let recipe: Recipe
    
    var body: some View {
        
        let deliveryCost = (recipe.cookTimeMinutes ?? 0) > 0 ? "\((recipe.cookTimeMinutes ?? 0)) JOD" : "Free"
        
        NavigationLink(destination: RecipeDetailView(viewModel: RecipeDetailViewModel(recipe: recipe))) {
            HStack(spacing: 12) {
                if let imageUrl = recipe.image, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(recipe.name ?? "")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text("⭐ \(String(format: "%.1f", recipe.rating ?? 0))")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    HStack(spacing: 15) {
                        Image(systemName: "clock")
                            .frame(width: 8, height: 8)
                            .foregroundColor(.gray)
                        Text("\(recipe.prepTimeMinutes ?? 0) min •")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Image(systemName: "bicycle")
                            .frame(width: 8, height: 8)
                            .foregroundColor(.gray)
                        Text("\(deliveryCost)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(6)
                }
                
                Spacer()
            }
            .padding(12)
            .frame(height: 120)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemBackground))
                    .shadow(color: Color.black.opacity(0.12), radius: 6, x: 0, y: 3)
            )
        }
        
    }
}

#Preview {
    RecipeRowView(recipe: Recipe(id: 1, name: "Delicious Pasta", ingredients: [""], instructions: [""], prepTimeMinutes: 2, cookTimeMinutes: 3, servings: 4, difficulty: "", cuisine: "", caloriesPerServing: 2, tags: [""], userID: 3, image: "", rating: 3.3, reviewCount: 1, mealType: [""]))
        .previewLayout(.sizeThatFits)
        .padding()
}
