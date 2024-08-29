//
//  ProductsView.swift
//  imarket
//
//  Created by riya on 8/26/24.
//

import SwiftUI

struct ProductsView: View {
    
    @ObservedObject var viewModel = ProductViewModel()
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemBackground).edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading, spacing: 0) {
                    SearchBar(text: $viewModel.searchText)
                        .padding()
                        .padding(.top, 23)
                    Divider()
                    if !viewModel.searchText.isEmpty {
                        HStack {
                            Text("\(viewModel.filteredProducts.count) results for")
                                .padding()
                                .font(.system(size: 17))
                            Text("\"\(viewModel.searchText)\"")
                                .font(.system(size: 17, weight: .bold))
                                .padding(.leading, -20)
                        }
                    }
                    List(viewModel.filteredProducts) { product in
                        HStack {
                            ZStack {
                                Color(.systemBackground)
                                    .frame(width: 128, height: 128)
                                    .cornerRadius(8)
                                AsyncImage(url: URL(string: product.thumbnail)) { image in image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill) // Adjusts image to fit within the frame
                                        .frame(width: 128, height: 128) // Ensures the image is properly sized
                                        .background(Color(.systemBackground))
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .clipped()
                                } placeholder: {
                                    // Placeholder while the image is loading
                                    ProgressView()
                                        .frame(width: 128, height: 128)
                                        .background(Color(.systemBackground))
                                }
                            }
                            VStack(alignment: .leading, spacing: 4) {
                                Text(product.title)
                                //                                .font(.headline)
                                    .foregroundColor(.primary) // Adapts to light/dark mode
                                    .font(.system(size: 17, weight: .regular, design: .default))
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                
                                Text("$\(product.price, specifier: "%.2f")")
                                //                                .font(.subheadline)
                                    .foregroundColor(.primary) // Adapts to light/dark mode
                                    .font(.system(size: 20, weight: .bold))
                                Text(product.category.capitalized)
                                    .font(.system(size: 13, weight: .regular, design: .default))
                                    .foregroundColor(.white)
                                    .padding(.vertical, 2)
                                    .padding(.horizontal, 4)
                                    .background(
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(Color(red: 58/255, green: 58/255, blue: 60/255))
                                    )
                                
                                Spacer().frame(height: 4)
                                
                                HStack() {
                                    Button(action: {
                                        viewModel.addToCart(product: product)
                                    }) {
                                        Text("Add to Cart")
                                            .font(.subheadline)
                                            .padding(8)
                                            .frame(maxWidth: 173, minHeight: 36)
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                            .cornerRadius(100)
                                            
                                    }
                                    .buttonStyle(BorderlessButtonStyle())
                                    
//                                    .padding(.trailing, 50)
                                    Button(action: {
                                        if viewModel.myItems.contains(where: { $0.id == product.id }) {
                                                // If the item is already in My Items, you could remove it (optional)
                                                viewModel.removeFromMyItems(product: product)
                                            } else {
                                                viewModel.addToMyItems(product2: product)
                                            }
                                    }) {
                                        Image(systemName: viewModel.myItems.contains(where: { $0.id == product.id }) ? "heart.fill" : "heart")
                                            .frame(maxWidth: 36, minHeight: 36)
                                            .background(
                                                Color(red: 58/255, green: 58/255, blue: 60/255) // Set the background color
                                                    .clipShape(Circle()) // Ensure the background color is applied to a circular shape
                                            )
                                            .foregroundColor(Color.white)
                                            
                                    }
                                    .buttonStyle(BorderlessButtonStyle())
                                }
                            }
                        }
                        .background(Color(.systemBackground))
                        .listRowBackground(Color(.systemBackground))
                        .listRowSeparator(.hidden)
                    }
                    
                    
                }
                .listStyle(PlainListStyle())
                .padding(.top, -40)
                .listRowSeparator(.hidden)
            }
            

            .onAppear {
                viewModel.fetchProducts()
            }
            
        }
        
    }
}

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .padding(.leading, 10)
                .font(.system(size: 17))
            TextField("What are you looking for?", text: $text)
                .foregroundColor(.primary)
                .autocapitalization(.none)
            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .padding(.trailing, 10)
                }
            }
        }
        .frame(maxWidth: .infinity, minHeight: 36)
        .background(Color(.systemGray5))
        .cornerRadius(100)
    }
}

#Preview {
    ProductsView()
        .preferredColorScheme(.light)
}
