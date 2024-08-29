//
//  MyItemsView.swift
//  imarket
//
//  Created by riya on 8/26/24.
//

import SwiftUI

struct MyItemsView: View {
    
    @ObservedObject var viewModel = ProductViewModel()
    

    var body: some View {
        NavigationView {
            List(viewModel.myItems) { product in
                HStack {
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
                        
                        HStack {
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
                            
                            Button(action: {
                                viewModel.removeFromMyItems(product: product)
                            }) {
                                Image(systemName: "heart.fill")
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
                .listRowSeparator(.hidden)
            }
            .background(Color(.systemBackground))
            .listRowBackground(Color(.systemBackground))
            .navigationTitle("My Items")
            
            .navigationBarTitleDisplayMode(.large)
            
            
        }
        .listStyle(PlainListStyle())
        .edgesIgnoringSafeArea(.top)
    }
    
}

#Preview {
    MyItemsView(viewModel: ProductViewModel())
}
