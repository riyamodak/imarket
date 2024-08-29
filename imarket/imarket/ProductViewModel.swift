//
//  ProductViewModel.swift
//  imarket
//
//  Created by riya on 8/26/24.
//

import Foundation
import Combine
import SwiftUI

class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var filteredProducts: [Product] = []
    @Published var cartItems: [Product] = []
    @Published var myItems: [Product] = []
    @Published var errorMessage: String?
    @Published var searchText: String = "" {
        didSet {
            filterProducts()
        }
    }
    
    var subtotal: Double {
            cartItems.reduce(0) { $0 + $1.price }
        }
        
        var salesTax: Double {
            subtotal * 0.0725
        }

        var totalCost: Double {
            subtotal + salesTax
        }

    init() {
        fetchProducts()
    }

    func fetchProducts() {
        let urlString = "https://dummyjson.com/products"

        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching products: \(error)")
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to load products: \(error.localizedDescription)"
                }
                return
            }

            guard let data = data else {
                print("No data returned from API")
                DispatchQueue.main.async {
                    self.errorMessage = "No data returned from API"
                }
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(ProductResponse.self, from: data)
                DispatchQueue.main.async {
                    self.products = decodedResponse.products
                    self.filterProducts()
                }
            } catch {
                print("Failed to decode JSON: \(error)")
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to decode products: \(error.localizedDescription)"
                }
            }
        }.resume()
    }

    private func filterProducts() {
        if searchText.isEmpty {
            filteredProducts = products
        } else {
            let lowercasedSearchText = searchText.lowercased()
            filteredProducts = products.filter { product in
                product.title.lowercased().contains(lowercasedSearchText) ||
                product.tags.contains(where: { $0.lowercased().contains(lowercasedSearchText) })
            }
        }
    }
    
    func addToCart(product: Product) {
        print("Adding to cart: \(product.title)")
        cartItems.append(product)
    }

    func removeFromCart(product: Product) {
        if let index = cartItems.firstIndex(where: { $0.id == product.id }) {
            cartItems.remove(at: index)
        }
    }
    
    func addToMyItems(product2: Product) {
        print("Adding to my items: \(product2.title)")
        myItems.append(product2)
    }
    
    func removeFromMyItems(product: Product) {
        if let index = myItems.firstIndex(where: { $0.id == product.id }) {
            myItems.remove(at: index)
        }
    }
}
