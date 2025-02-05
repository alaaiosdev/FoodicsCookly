//
//  RecipeListView.swift
//  FoodicsCookly
//
//  Created by Alaa Abu-Taha on 04/02/2025.
//

import SwiftUI

//struct RecipeListView: View {
//    @StateObject var viewModel: RecipeListViewModel
//    
//    var body: some View {
//        NavigationView {
//            List(viewModel.recipes) { recipe in
//                NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
//                    HStack {
//                        if let imageUrl = recipe.image, let url = URL(string: imageUrl) {
//                            AsyncImage(url: url) { image in
//                                image.resizable()
//                                    .scaledToFill()
//                            } placeholder: {
//                                ProgressView()
//                            }
//                            .frame(width: 50, height: 50)
//                            .clipShape(RoundedRectangle(cornerRadius: 10))
//                        }
//                        Text(recipe.name ?? "")
//                            .font(.headline)
//                    }
//                }
//            }
//            .navigationTitle("Recipes")
//            .refreshable {
//                viewModel.reloadData()
//            }
//            .overlay {
//                if viewModel.loadingState.isLoading {
//                    ProgressView()
//                        .progressViewStyle(CircularProgressViewStyle())
//                        .padding()
//
//                }
//            }
//        }
////        .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
////            Button("OK", role: .cancel) { viewModel.errorMessage = nil }
////        } message: {
////            Text(viewModel.errorMessage ?? "")
////        }
//        
////        .alert("Error", isPresented: .constant(viewModel.loadingState.errorMessage != nil)) {
////            Button("OK", role: .cancel) { viewModel.loadingState = .idle }
////        } message: {
////            Text(viewModel.loadingState.errorMessage ?? "")
////        }
//
//        .alert(isPresented: .constant(viewModel.loadingState.errorMessage != nil)) {
//            Alert(
//                title: Text("Error"),
//                message: Text(viewModel.loadingState.errorMessage ?? ""),
//                dismissButton: .default(Text("OK")) {
//                }
//            )
//        }
//    }
//}

//struct RecipeListView: View {
//    @StateObject var viewModel: RecipeListViewModel
//    @State private var searchQuery: String = ""  // For search functionality
//    @State private var selectedSortOption: SortOption = .rating  // For sorting recipes
//
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                LazyVStack(spacing: 12) {
//                    ForEach(viewModel.recipes) { recipe in
//                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
//                            HStack(spacing: 12) {
//                                if let imageUrl = recipe.image, let url = URL(string: imageUrl) {
//                                    AsyncImage(url: url) { image in
//                                        image.resizable()
//                                            .scaledToFill()
//                                    } placeholder: {
//                                        ProgressView()
//                                    }
//                                    .frame(width: 80, height: 80)
//                                    .clipShape(RoundedRectangle(cornerRadius: 10))
//                                }
//
//                                VStack(alignment: .leading, spacing: 4) {
//                                    Text(recipe.name ?? "")
//                                        .font(.headline)
//                                        .foregroundColor(.primary)
//                                    
//                                    Text("⭐ \(String(format: "%.1f", recipe.rating ?? 0))")
//                                        .font(.subheadline)
//                                        .foregroundColor(.secondary)
//                                    
//                                    HStack(spacing: 15) {
//                                        Image(systemName: "clock")
//                                            .frame(width: 8, height: 8)
//                                            .foregroundColor(.gray)
//                                        Text("\(recipe.cookTimeMinutes ?? 0) min •")
//                                            .font(.subheadline)
//                                            .foregroundColor(.secondary)
//                                        
//                                        Image(systemName: "bicycle")
//                                            .frame(width: 8, height: 8)
//                                            .foregroundColor(.gray)
//                                        Text("\(recipe.prepTimeMinutes ?? 0)")
//                                            .font(.subheadline)
//                                            .foregroundColor(.secondary)
//                                    }
//                                    .padding(6)
//                                }
//                                                                
//                                Spacer()
//                            }
//                            .padding(12)
//                            .frame(height: 120)
//                            .background(
//                                RoundedRectangle(cornerRadius: 12)
//                                    .fill(Color(.systemBackground))
//                                    .shadow(color: Color.black.opacity(0.12), radius: 6, x: 0, y: 3)
//                            )
//                        }
//                    }
//                }
//                .padding(.horizontal, 16)
//            }
//            .navigationTitle("Recipes")
//            .refreshable {
//                viewModel.reloadData()
//            }
//            .overlay {
//                if viewModel.loadingState.isLoading {
//                    ProgressView()
//                        .progressViewStyle(CircularProgressViewStyle())
//                        .padding()
//                }
//            }
//        }
//        .alert(isPresented: .constant(viewModel.loadingState.errorMessage != nil)) {
//            Alert(
//                title: Text("Error"),
//                message: Text(viewModel.loadingState.errorMessage ?? ""),
//                dismissButton: .default(Text("OK")) {}
//            )
//        }
//    }
//}
struct RecipeListView: View {
    @StateObject var viewModel: RecipeListViewModel
    @State private var searchQuery: String = ""  // For search functionality
    @State private var selectedSortOption: SortOption = .rating  // For sorting recipes
    
    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                
                TextField("Search recipes...", text: $searchQuery)
//                    .padding()  // Internal padding to ensure text is not cramped
                    .background(Color.gray.opacity(0.2), in: RoundedRectangle(cornerRadius: 8))
//                    .padding(.horizontal)
                    .onChange(of: searchQuery) { _ in
                        viewModel.filterRecipes(query: searchQuery)  // Filter recipes based on the search query
                    }
                    
                    .padding(.horizontal)
//                    .frame(height: 44)  // Set a custom height (you can adjust this value)

                
//                TextField("Search recipes...", text: $searchQuery)
//                    .padding(.vertical, 12)  // Adjust vertical padding to change the height
////                    .padding(.horizontal, 20)  // Add margin from the left and right
//                    .background(Color.gray.opacity(0.2), in: RoundedRectangle(cornerRadius: 8))
//                    .onChange(of: searchQuery) { _ in
//                        viewModel.filterRecipes(query: searchQuery)  // Filter recipes based on the search query
//                    }
//                    .frame(height: 50)  // Ensures that the height is at least 50

                // Sort Options
                Picker("Sort by", selection: $selectedSortOption) {
                    ForEach(SortOption.allCases, id: \.self) { option in
                        Text(option.displayName).tag(option)
                    }
                }
                .onChange(of: selectedSortOption) { _ in
                    viewModel.sortRecipes(by: selectedSortOption)  // Sort the recipes whenever the user changes the sort option
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                // Recipe List
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.filteredRecipes) { recipe in
                            
                            let deliveryCost = (recipe.cookTimeMinutes ?? 0) > 0 ? "\((recipe.cookTimeMinutes ?? 0)) JOD" : "Free"
                            
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
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
                    .padding(.horizontal, 16)
                }
                .overlay {
                    if viewModel.loadingState.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding()
                    }
                }
            }
            .navigationTitle("Recipes")
            .refreshable {
                viewModel.reloadData()
            }
            .alert(isPresented: .constant(viewModel.loadingState.errorMessage != nil)) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.loadingState.errorMessage ?? ""),
                    dismissButton: .default(Text("OK")) {}
                )
            }
        }
    }
}

enum SortOption: String, CaseIterable {
    case rating
    case deliveryFree
    
    var displayName: String {
        switch self {
        case .rating: return "Rating"
        case .deliveryFree: return "Delivery Free"
        }
    }
}
