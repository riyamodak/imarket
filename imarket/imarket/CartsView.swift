//
//  CartsView.swift
//  imarket
//
//  Created by riya on 8/26/24.
//

import SwiftUI

struct CartsView: View {
    @ObservedObject var viewModel: ProductViewModel 
    @State private var selectedOption: String = "Pick up"
    @State private var isOrderSummaryExpanded: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack {
                    Menu {
                       Button(action: {
                           selectedOption = "Pick up"
                       }) {
                           Text("Pick up")
                       }

                       Button(action: {
                           selectedOption = "Delivery"
                       }) {
                           Text("Delivery")
                       }
                    } label: {
                        Text(selectedOption)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.primary)
                        Image(systemName: "chevron.down")
                            .font(.system(size: 16, weight: .bold))
                            .padding(.leading, -4)
                            .foregroundColor(.primary)
                    }
                    .menuStyle(BorderlessButtonMenuStyle())
                    
                    Text("from")
                        .font(.system(size: 17))
                        .foregroundColor(Color(UIColor.systemGray2))
                        .padding(.leading, -2)
                    Text("Cupertino")
                        .font(.system(size: 16, weight: .bold))
                        .underline()
                        .padding(.leading, -2)
                
                    Spacer()
                }
                .padding(.leading)
                
                List(viewModel.cartItems) { product in
                    HStack {
                        AsyncImage(url: URL(string: product.thumbnail)) { image in image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 40, height: 40)
                                .background(Color(.systemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .clipped()
                        } placeholder: {
                            ProgressView()
                                .frame(width: 40, height: 40)
                        }
                        
                        Text(product.title)
                            .font(.system(size: 17))
                            .frame(width: 175, height: 22, alignment: .leading)
                            .lineLimit(1)
                            
                        Spacer()
                        
                        Text("$\(product.price, specifier: "%.2f")")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.primary)
                        
                        Button(action: {
                            viewModel.removeFromCart(product: product)
                        }) {
                            Image(systemName: "xmark")
                                .font(.system(size: 16))
                                .foregroundColor(.primary)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(PlainListStyle())
                .frame(maxHeight: .infinity)
                
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("$\(viewModel.totalCost, specifier: "%.2f")")
                            .font(.system(size: 20, weight: .bold))
                        Text("total")
                            .font(.system(size: 20, weight: .bold))
                            .padding(.leading, -4)
                        Spacer()
                        Button(action: {
                            isOrderSummaryExpanded.toggle()
                        }) {
                            Image(systemName: isOrderSummaryExpanded ? "chevron.up" : "chevron.down")
                                .foregroundColor(.primary)
                        }
                    }
                        
                    Text("\(viewModel.cartItems.count) items")
                        .font(.system(size: 17))
                        .foregroundColor(.secondary)
                        .padding(.top, -8)
                        
                        if isOrderSummaryExpanded {
                            Divider()
                            HStack {
                                Text("Subtotal")
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text("$\(viewModel.subtotal, specifier: "%.2f")")
                            }
                            HStack {
                                Text("Savings")
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text("$0.00")
                            }
                            HStack {
                                Text("Taxes")
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text("$\(viewModel.salesTax, specifier: "%.2f")")
                            }
                        }
                    }
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .padding(.bottom)

                
                Spacer()
                
                
                Button(action: {
                    // Implement check out action here
                }) {
                    Text("Check out")
                        .font(.system(size: 17))
                        .frame(maxWidth: 361, minHeight: 36)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(100)
                }
                .padding(.horizontal)
                .padding(.bottom)

            }
            .navigationTitle("Cart")
           }
           
       }
}


#Preview {
    CartsView(viewModel: ProductViewModel())
        .preferredColorScheme(.dark)
}
