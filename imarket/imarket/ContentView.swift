//
//  ContentView.swift
//  imarket
//
//  Created by riya on 8/26/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ProductViewModel() // Single instance of the view model
    
    init() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = UIColor.systemBackground
        tabBarAppearance.shadowColor = UIColor.separator
        UITabBar.appearance().standardAppearance = tabBarAppearance
    }


    var body: some View {
        TabView {
            ProductsView(viewModel: viewModel) // Pass the view model to ProductsView
                .tabItem {
                    Label("Products", systemImage: "carrot")
                }
            MyItemsView(viewModel: viewModel) // Pass the view model to MyItemsView
                .tabItem {
                    Label("My Items", systemImage: "heart.fill")
                }
            CartsView(viewModel: viewModel) // Pass the view model to CartsView
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }
                .badge(viewModel.cartItems.count)
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
