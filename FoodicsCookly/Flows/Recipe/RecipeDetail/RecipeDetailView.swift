//
//  RecipeDetailView.swift
//  FoodicsCookly
//
//  Created by Alaa Abu-Taha on 04/02/2025.
//

import SwiftUI

struct RecipeDetailView: View {
    @StateObject var viewModel: RecipeDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                if let imageUrl = viewModel.image {
                    AsyncImage(url: URL(string: imageUrl)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .scaledToFill()
                                .frame(maxWidth: .infinity, maxHeight: 300)
                                .frame(height: 300)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(8)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity, maxHeight: 300)
                                .clipped()
                                .cornerRadius(8)
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity, maxHeight: 300)
                                .foregroundColor(.gray)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(8)
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
                
                Text(viewModel.name ?? "")
                    .font(.largeTitle)
                    .bold()
                
                Text("name: \(viewModel.name ?? "")")
                    .font(.body)
                
                Text("prep Time: \(viewModel.prepTimeMinutes ?? 0) mins")
                    .font(.body)
                
                Text("cook Time: \(viewModel.cookTimeMinutes ?? 0) mins")
                    .font(.body)
                
                Text("Cuisine: \(viewModel.cuisine ?? "")")
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle("Recipe Detail")
    }
}
