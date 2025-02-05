//
//  RecipeListView.swift
//  FoodicsCookly
//
//  Created by Alaa Abu-Taha on 04/02/2025.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject var viewModel: RecipeListViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                
                TextField("Search for a recipe...", text: $viewModel.searchQuery)
                    .padding(8)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(6)
                    .frame(height: 40)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.filteredRecipes) { recipe in
                            
                            RecipeRowView(recipe: recipe)
                                .onAppear {
                                    viewModel.loadMoreIfNeeded(currentItem: recipe)
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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(action: { viewModel.sortBy() }) {
                            Label("Sort By", systemImage: "line.horizontal.3.decrease.circle")
                        }
                        Button(action: { viewModel.toggleOrder() }) {
                            Label("Order", systemImage: "arrow.up.arrow.down")
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
            
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
